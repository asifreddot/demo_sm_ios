//
//  SignupViewModel.swift
//  smart to do
//
//  Created by Asif Reddot on 25/2/24.
//

import Foundation

class SignupViewModel {
    var createAccountRequest = CreateAccountRequest()
    
    func requestCreateAccount(_ completion: @escaping(_ success: Bool) -> Void) {
        createAccountRequest.role = "user"
        
        NetworkServiceLogic.genericNetworkRequest(params: createAccountRequest, responseObject: CreateAccountResponse(), requestMethod: .post, showAlert: false, requestURL: NetworkConstants.API.createAccount) { responseObject in
            
            if let response = responseObject, let responseData = response.data {
                completion(true)
            }
        }
    }
}
