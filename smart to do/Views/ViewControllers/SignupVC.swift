//
//  SignupVC.swift
//  smart to do
//
//  Created by Asif Reddot on 25/2/24.
//

import UIKit

class SignupVC: BaseViewController {
    @IBOutlet weak var labelTitle1: Inter500Size20Color061053!
    @IBOutlet weak var labelTitle2: Inter400Size14Color061053Alpha65!
    @IBOutlet weak var textFieldEmail: SignupEmailTextField!
    @IBOutlet weak var textFieldPhone: SignupPhoneTextField!
    @IBOutlet weak var labelPasswordInstruction: Inter400Size12Color061053!
    @IBOutlet weak var textFieldPassword: SignupPasswordTextField!
    @IBOutlet weak var textFieldConfirmPassword: SignupPasswordTextField!
    @IBOutlet weak var buttonCreateAccount: LoginButton!
    @IBOutlet weak var textFieldName: SignupNameTextField!
    
    var viewModel = SignupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationUISetup(isBackButtonHidden: false, title: "Sign Up")
        setupView()
    }
    
    @IBAction func buttonActionCreateAccount(_ sender: Any) {
        view.endEditing(true)
        verifyUserData()
    }
}

extension SignupVC {
    func setupView() {
        labelTitle1.text = "Create New Account"
        labelTitle2.text = "Please enter your details, Its easy."
        labelPasswordInstruction.text = "Must be at least 8 characters"
        buttonCreateAccount.setTitle("Create Account", for: .normal)
        
        textFieldConfirmPassword.attributedPlaceholder = NSAttributedString(
            string: "Enter confirm password",
            attributes: [
                NSAttributedString.Key.foregroundColor: CustomColors().color061053,
                NSAttributedString.Key.font: UIFont(name: Fonts.Inter.weight400, size: getFontSizeWithRespectToDevice(minimumFontSize: FontSize.size14.rawValue)) ?? UIFont.systemFont(ofSize: FontSize.size14.rawValue)
            ]
        )
    }
}

//MARK: Get User Data and api call
extension SignupVC {
    func verifyUserData() {
        if textFieldEmail.text != nil, let emailVal = textFieldEmail.text {
            viewModel.createAccountRequest.email = emailVal
        }
        
        if textFieldName.text != nil, let nameVal = textFieldName.text {
            viewModel.createAccountRequest.name = nameVal
        }
        
        if textFieldPassword.text != nil && textFieldConfirmPassword.text != nil {
            let passwordVal = textFieldPassword.text
            let confirmPasswordVal = textFieldConfirmPassword.text
            
            if (passwordVal != "" && confirmPasswordVal != "") && (passwordVal == confirmPasswordVal) {
                viewModel.createAccountRequest.password = passwordVal
            }
        }
        
        viewModel.requestCreateAccount() { [weak self] success in
            guard let self = self else { return }
            
            if success {
                DispatchQueue.main.async {
                    self.showToast(message: "User created successfully!")
                    self.backToLogin()
                }
            }
        }
    }
}

extension SignupVC {
    func backToLogin() {
        self.clickedOnBack()
    }
}
