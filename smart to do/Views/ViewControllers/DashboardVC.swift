//
//  DashboardVC.swift
//  smart to do
//
//  Created by Asif Reddot on 25/2/24.
//

import UIKit

class DashboardVC: UIViewController {
    
    @IBOutlet weak var viewCreateTask: UIView!
    @IBOutlet weak var tableViewTasks: UITableView!
    @IBOutlet weak var textFieldSearch: DashboardSearchTextField!
    @IBOutlet weak var imageViewRefresh: UIImageView!
    
    var isFirstLogin: Bool = false
    var viewModel = DashboardViewModel()
    var rotationTimer: Timer?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setListener()
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        ReachabilityManager.shared.startMonitoring()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityChanged),
                                               name: NSNotification.Name("ReachabilityChangedNotification"),
                                               object: nil)
        
        if isFirstLogin {
            getDataFromServer()
        } else {
            getDataFromLocal()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
}

//MARK: Set Views
extension DashboardVC {
    func setupView() {
        viewCreateTask.clipsToBounds = true
        viewCreateTask.layer.cornerRadius = viewCreateTask.frame.width/2
        
        tableViewTasks.delegate = self
        tableViewTasks.dataSource = self
        
        textFieldSearch.delegate = self
        
        tableViewTasks.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
    }
}

//MARK: Add Listeners
extension DashboardVC {
    func setListener() {
        viewCreateTask.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navigateToCreateItem(_ :))))
    }
}

//MARK: Navigation Methods
extension DashboardVC {
    @objc func navigateToCreateItem(_ sender: UITapGestureRecognizer) {
        print("Tap on create item")
        if let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateItemVC") as? CreateItemVC {
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
}

//MARK: Get Data
extension DashboardVC {
    func getDataFromLocal() {
        reloadTableData()
        
        if ReachabilityManager.shared.isNetworkAvailable && !isFirstLogin {
            checkDataUpdateStatus()
        }
    }
    
    func getDataFromServer() {
        isFirstLogin = false
        
        DispatchQueue.main.async {
            self.viewModel.getListFromServer() { [weak self] success, taskList in
                guard let self = self else {return}
                
                for item in taskList {
                    let newItem = ToDoListITem(context: CoreDataService.shared.context)
                    newItem.id = Int64(item.id ?? 0)
                    newItem.assignee_user = Int64(UserPreference.shared.getIntForKey(UserPreferenceAppInfoData.userId.rawValue))
                    newItem.completed = false
                    newItem.create_date = Date()
                    newItem.title = item.title
                    newItem.item_description = item.description
                    newItem.sync_status = Int64(TaskStatus.synced.rawValue)
                    
                    CoreDataService.shared.saveData(newItem)
                    print("item added")
                }
                
                if success {
                    self.reloadTableData()
                }
            }
        }
    }
    
    func reloadTableData() {
        viewModel.localItems = CoreDataService.shared.fetchData()
        
        viewModel.filterItems() { success in
            if success {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                    guard let self = self else { return }
                    self.tableViewTasks.reloadData()
                }
            }
        }
    }
}

//MARK: UItableView Data Source
extension DashboardVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell") as? TaskTableViewCell else {
            return UITableViewCell.init()
        }
        
        let dataModel = viewModel.tableViewData?[indexPath.row] ?? ToDoListITem()
        
        cell.delegate = self
        cell.updateCell(dataModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: UITableView Delegate
extension DashboardVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataModel = viewModel.tableViewData?[indexPath.row]
        
        if let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditItemVC") as? EditItemVC {
            nextVC.itemToEdit = dataModel ?? ToDoListITem()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.tableViewData?[indexPath.row].sync_status = Int64(TaskStatus.delete.rawValue)
            deleteItem(viewModel.tableViewData?[indexPath.row] ?? ToDoListITem())
        }
    }
}

extension DashboardVC: TaskTableViewDelegate {
    func markAsComplete(_ item: ToDoListITem) {
        for i in 0..<(viewModel.tableViewData?.count ?? 0) {
            if item.id == Int(viewModel.tableViewData?[i].id ?? 0) {
                DispatchQueue.main.async {
                    let indexPath = IndexPath(row: i, section: 0)
                    self.tableViewTasks.reloadRows(at: [indexPath], with: .fade)
                    
                }
                break
            }
        }
    }
}

//MARK: Network connection Change Action
extension DashboardVC {
    @objc func reachabilityChanged() {
        if ReachabilityManager.shared.isNetworkAvailable {
            viewModel.updateData()
        } else {
            // Handle case when network is not available
            print("Network is not available")
        }
    }
}

extension DashboardVC {
    func checkDataUpdateStatus() {
        startRotationAnimation()
        viewModel.updateData()
    }
    
    func deleteItem(_ item: ToDoListITem) {
        if ReachabilityManager.shared.isNetworkAvailable {
            viewModel.checkItemForDelete()
        } else {
            reloadTableData()
        }
    }
    
    func completeItem(_ item: ToDoListITem) {
        if ReachabilityManager.shared.isNetworkAvailable {
            viewModel.checkItemForDelete()
        } else {
            reloadTableData()
        }
    }
    
    func startRotationAnimation() {
        rotationTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(stopRotationAnimation), userInfo: nil, repeats: false)
        
        rotationTimer = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(rotateImageView), userInfo: nil, repeats: true)
    }
    
    @objc func rotateImageView() {
        imageViewRefresh.transform = imageViewRefresh.transform.rotated(by: .pi / 18)
    }
    
    @objc func stopRotationAnimation() {
        // Stop the rotation animation
        rotationTimer?.invalidate()
        rotationTimer = nil
        
        UIView.animate(withDuration: 0.03) {
            self.imageViewRefresh.transform = .identity
        }
    }
}

extension DashboardVC: DashboardDelegate {
    func itemDeleted() {
        
        for item in CoreDataService.shared.deletedItemList {
            do {
                context.delete(item)
                try context.save()
            } catch {
                // Handle the error, e.g., print an error message or show an alert
                print("Error deleting item: \(error)")
            }
        }
        
        reloadTableData()
    }
    
    func itemUpdated() {
        reloadTableData()
    }
}

extension DashboardVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        
        filterText(text)
        return true
    }
}

extension DashboardVC {
    func filterText(_ query: String) {
        
        if query.isEmpty {
            reloadTableData()
            return
        } else {
            let filteredData = viewModel.tableViewDataForFilter?.filter { $0.title?.lowercased().contains(query.lowercased()) ?? false }
            viewModel.tableViewData = filteredData
            tableViewTasks.reloadData()
        }
    }
    
}
