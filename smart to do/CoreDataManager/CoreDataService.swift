//
//  CoreDataService.swift
//  smart to do
//
//  Created by Asif Reddot on 26/2/24.
//

import Foundation
import UIKit

enum TaskStatus: Int {
    case synced = 1
    case add = 2
    case delete = 3
    case update = 4
}

class CoreDataService {
    static let shared = CoreDataService()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemList: [ToDoListITem] = []
    var newItemList: [ToDoListITem] = []
    var updatedItemList: [ToDoListITem] = []
    var deletedItemList: [ToDoListITem] = []
    
    func fetchData() -> [ToDoListITem] {
        
        do {
            itemList = try context.fetch(ToDoListITem.fetchRequest())
            return itemList
        } catch {
            // Handle the error here
            print("Error fetching data: \(error)")
            return []
        }
    }
    
    func saveData(_ newTask: ToDoListITem) {
        do {
            try self.context.save()
        } catch {
            
        }
    }
}
