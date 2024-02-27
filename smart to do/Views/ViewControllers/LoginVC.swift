//
//  ViewController.swift
//  smart to do
//
//  Created by Asif Reddot on 22/2/24.
//

import UIKit
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

class LoginVC: UIViewController {
    
    @IBOutlet weak var textFieldEmail: LoginEmailTextField!
    @IBOutlet weak var textFieldPassword: LoginPasswordTextField!
    @IBOutlet weak var buttonLogin: LoginButton!
    @IBOutlet weak var labelSocialSiginHeader: Inter400Size13Color061053!
    @IBOutlet weak var labelLoginHeader: Inter400Size20Color061053!
    @IBOutlet weak var labelSignupTitle: Inter400Size13Color061053!
    @IBOutlet weak var viewGoogleSignin: UIView!
    @IBOutlet weak var labelGoogleSignin: Inter400Size14Color061053!
    @IBOutlet weak var labelSignup: Inter500Size13Color009B3E!
    @IBOutlet weak var buttonTogglePassword: UIButton!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupListener()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    @IBAction func buttonActionLogin(_ sender: Any) {
        view.endEditing(true)
        
        verifyUserData()
    }
    
    @IBAction func buttonActionTogglePassword(_ sender: Any) {
        textFieldPassword.isSecureTextEntry = !textFieldPassword.isSecureTextEntry
    }
}

//MARK: Set up initial view
extension LoginVC {
    func setupView() {
        labelLoginHeader.text = "Login to your account"
        labelSocialSiginHeader.text = "Or login with"
        labelGoogleSignin.text = "Continue with Google"
        labelSignupTitle.text = "Don’t have an account?"
        labelSignup.text = "Sign Up"
        
        buttonLogin.setTitle("Login", for: .normal)
    }
    
    func setupListener() {
        viewGoogleSignin.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGoogleSignin(_ :))))
        labelSignup.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapSingup(_ :))))
    }
}

//MARK: Custom functions
extension LoginVC {
    @objc func tapGoogleSignin(_ sender: UITapGestureRecognizer) {
        print("Tap Google Signin!!")
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }

            viewModel.socialRequestLogin(user.accessToken.tokenString, user.profile?.name ?? "", user.profile?.email ?? "") {[weak self] success in
                guard let self = self else {return}
                if success {
                    DispatchQueue.main.async {
                        self.navigateToDashboard()
                    }
                }
            }
        }
        
    }
    
    @objc func tapSingup(_ sender: UITapGestureRecognizer) {
        print("Tap Singup!!")
        if let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignupVC") as? SignupVC {
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
}

extension LoginVC {
    func verifyUserData() {
        if textFieldEmail.text != nil, let emailVal = textFieldEmail.text {
            viewModel.loginRequest.email = emailVal
        }
        if textFieldPassword.text != nil && textFieldPassword.text != "" {
            viewModel.loginRequest.password = textFieldPassword.text
        }
        
        viewModel.requestLogin() { [weak self] success in
            guard let self = self else {return}
            if success {
                DispatchQueue.main.async {
                    self.navigateToDashboard()
                }
            }
        }
    }
    
    func navigateToDashboard() {
        if let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DashboardVC") as? DashboardVC {
            nextVC.isFirstLogin = true
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
}
