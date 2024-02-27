//
//  DashboardViewModel.swift
//  smart to do
//
//  Created by Asif Reddot on 26/2/24.
//

import Foundation

protocol DashboardDelegate: AnyObject {
    func itemUpdated()
    func itemDeleted()
}

class DashboardViewModel {
    var localItems: [ToDoListITem]?
    var tableViewData: [ToDoListITem]?
    var tableViewDataForFilter: [ToDoListITem]?
    var isNetworkConnected: Bool = false
    
    weak var delegate: DashboardDelegate?
    
    func getListFromServer(_ completion: @escaping(_ success: Bool, _ taskList: [Task]) -> Void) {
        NetworkServiceLogic.genericNetworkRequest(params: nil, responseObject: TaskListResponse(), requestMethod: .get, showAlert: false, requestURL: NetworkConstants.API.taskList) { responseObject in
            
            if let response = responseObject, let responseData = response.data?.first {
                let serverList = responseData.data
                
                completion(true, serverList ?? [])
            }
        }
    }
    
    func filterItems(_ completion: @escaping(_ success: Bool) -> Void) {
        guard let localItems = localItems else {
            return
        }

        tableViewData = localItems.filter { $0.sync_status != 3 }
        tableViewDataForFilter = localItems.filter { $0.sync_status != 3 }
        completion(true)
    }
    
    func updateData() {
        
        localItems = CoreDataService.shared.fetchData()
        
        checkItemForDelete()
        checkItemForAdd()
        checkItemForUpdate()
    }
    
    func checkItemForDelete() {
        CoreDataService.shared.deletedItemList = localItems?.filter { $0.sync_status == 3 } ?? []
        
        if !CoreDataService.shared.deletedItemList.isEmpty {
            
            for item in CoreDataService.shared.deletedItemList {
                var deleteRequest = UpdateStatusRequest()
                
                deleteRequest.id = Int(item.id)
                deleteRequest.status = "delete"
                
                NetworkServiceLogic.genericNetworkRequest(params: deleteRequest, responseObject: TaskDeleteResponse(), requestMethod: .post, showAlert: false, requestURL: NetworkConstants.API.taskDelete) { responseObject in
                    
                    if let response = responseObject, let responseData = response.data?.first {
                        self.delegate?.itemDeleted()
                    }
                }
            }
        }
    }
    
    func checkItemForUpdate() {
        CoreDataService.shared.updatedItemList = localItems?.filter { $0.sync_status == TaskStatus.update.rawValue } ?? []
        
        if !CoreDataService.shared.updatedItemList.isEmpty {
            for item in CoreDataService.shared.updatedItemList {
                var updateRequest = UpdateTaskRequest()
                
                updateRequest.id = Int(item.id)
                updateRequest.title = item.title
                updateRequest.description = item.description
                
                NetworkServiceLogic.genericNetworkRequest(params: updateRequest, responseObject: TaskUpdateResponse(), requestMethod: .post, showAlert: false, requestURL: NetworkConstants.API.taskUpdate) { responseObject in
                    
                    if let response = responseObject {
                        print("Updated Successfully!")
                    }
                }
            }
            
            updateAddedItemsInLocalList(CoreDataService.shared.updatedItemList)
        }
    }
    
    func checkItemForAdd() {
        CoreDataService.shared.newItemList = localItems?.filter { $0.sync_status == TaskStatus.add.rawValue } ?? []
        
        var newItemServiceList = [Task]()
        if !CoreDataService.shared.newItemList.isEmpty {
            for item in CoreDataService.shared.newItemList {
                newItemServiceList.append(Task(title: item.title, description: item.item_description, sync_id: String(item.sync_id)))
            }
            
            var addTaskRequest = AddTaskRequest()
            addTaskRequest.tasks = newItemServiceList
            
            NetworkServiceLogic.genericNetworkRequestForBaseResponse(params: addTaskRequest, responseObject: BaseResponseString(), requestMethod: .post, showAlert: false, requestURL: NetworkConstants.API.taskAdd) { responseObject, failedObject  in
                
                if let response = responseObject {
                    self.updateAddedItemsInLocalList(CoreDataService.shared.newItemList)
                }
            }
        }
    }
    
    func updateAddedItemsInLocalList(_ itemList: [ToDoListITem]) {
        for item in itemList {
            item.sync_status = Int64(TaskStatus.synced.rawValue)
            do {
                try CoreDataService.shared.context.save()
            } catch {
                
            }
        }
        
        delegate?.itemUpdated()
    }
}
