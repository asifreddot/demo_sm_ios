//
//  EditItemViewModel.swift
//  smart to do
//
//  Created by Asif Reddot on 27/2/24.
//

import Foundation

class EditItemViewModel {
    
    func editItem(_ itemToEdit: ToDoListITem, _ completion: @escaping(_ success: Bool) -> Void) {
        itemToEdit.sync_status = Int64(TaskStatus.update.rawValue)
        
        do {
            try CoreDataService.shared.context.save()
        } catch {
            
        }
        
        completion(true)
    }
}
