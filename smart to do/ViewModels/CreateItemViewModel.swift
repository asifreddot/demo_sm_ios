//
//  CreateItemViewModel.swift
//  smart to do
//
//  Created by Asif Reddot on 26/2/24.
//

import Foundation

class CreateItemViewModel {
    
    func addNewItem(_ taskName: String, _ taskDescription: String, _ completion: @escaping(_ success: Bool) -> Void) {
        let newItem = ToDoListITem(context: CoreDataService.shared.context)
        newItem.completed = false
        newItem.create_date = Date()
        newItem.title = taskName
        newItem.item_description = taskDescription
        newItem.sync_status = Int64(TaskStatus.add.rawValue)
        newItem.sync_id = Int64(CoreDataService.shared.itemList.count + 1)
        
        CoreDataService.shared.saveData(newItem)
        
        completion(true)
    }
}
