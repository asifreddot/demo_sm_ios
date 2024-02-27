//
//  CreateItemVC.swift
//  smart to do
//
//  Created by Asif Reddot on 25/2/24.
//

import UIKit

class EditItemVC: BaseViewController {
    @IBOutlet weak var labelTaskName: Inter400Size16Color061053!
    @IBOutlet weak var buttonSaveItem: LoginButton!
    @IBOutlet weak var textFieldTaskName: CreateTaskTextField!
    @IBOutlet weak var textViewTaskDescription: TaskDescriptionTextView!
    
    var viewModel = EditItemViewModel()
    var itemToEdit = ToDoListITem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationUISetup(isBackButtonHidden: false, title: "Edit")
        
        setupView()
    }
    
    @IBAction func buttonActionSaveItem(_ sender: Any) {
        view.endEditing(true)
        
        verifyData()
    }
}

extension EditItemVC {
    func setupView() {
        buttonSaveItem.setTitle("Save", for: .normal)
        textFieldTaskName.text = itemToEdit.title
        textViewTaskDescription.text = itemToEdit.item_description
    }
}

extension EditItemVC {
    func verifyData() {
        if textFieldTaskName.text != nil && textViewTaskDescription != nil {
            itemToEdit.title = textFieldTaskName.text
            itemToEdit.item_description = textViewTaskDescription.text
            viewModel.editItem(itemToEdit) { [weak self] success in
                
                guard let self = self else {return}
                
                if success {
                    self.clickedOnBack()
                }
            }
        }
    }
}
