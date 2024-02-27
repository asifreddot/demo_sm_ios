//
//  CreateItemVC.swift
//  smart to do
//
//  Created by Asif Reddot on 25/2/24.
//

import UIKit

class CreateItemVC: BaseViewController {
    @IBOutlet weak var labelTaskName: Inter400Size16Color061053!
    @IBOutlet weak var buttonSaveItem: LoginButton!
    @IBOutlet weak var textFieldTaskName: CreateTaskTextField!
    @IBOutlet weak var textViewTaskDescription: TaskDescriptionTextView!
    
    var viewModel = CreateItemViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationUISetup(isBackButtonHidden: false, title: "Create New Task")
        
        setupView()
    }
    
    @IBAction func buttonActionSaveItem(_ sender: Any) {
        view.endEditing(true)
        
        verifyData()
    }
}

extension CreateItemVC {
    func setupView() {
        buttonSaveItem.setTitle("Save", for: .normal)
    }
}

extension CreateItemVC {
    func verifyData() {
        if textFieldTaskName.text != nil && textViewTaskDescription != nil {
            
            viewModel.addNewItem(textFieldTaskName.text ?? "", textViewTaskDescription.text) { [weak self] success in
                
                guard let self = self else {return}
                
                if success {
                    self.clickedOnBack()
                }
            }
        }
    }
}
