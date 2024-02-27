//
//  LoginViewModel.swift
//  smart to do
//
//  Created by Asif Reddot on 25/2/24.
//

import Foundation

class LoginViewModel {
    var loginRequest = LoginRequest()
    
    func requestLogin(_ completion: @escaping(_ success: Bool) -> Void) {
        NetworkServiceLogic.genericNetworkRequest(params: loginRequest, responseObject: LoginResponse(), requestMethod: .post, showAlert: false, requestURL: NetworkConstants.API.login) { responseObject in
            
            if let response = responseObject, let responseData = response.data?.first {
                print("The token is: \(responseData.access_token ?? "")")
                KeyChainPreference.shared.save(key: KeyChainKey.authToken.rawValue, value: responseData.access_token ?? "")
                UserPreference.shared.setIntForKey(responseData.user?.id ?? 0, key: UserPreferenceAppInfoData.userId.rawValue)
                completion(true)
            }
        }
    }
    
    func socialRequestLogin(_ providerId: String, _ userName: String, _ email: String, _ completion: @escaping(_ success: Bool) -> Void) {
        var socialRequest = SocialLoginRequest()
        socialRequest.provider_id = providerId
        socialRequest.name = userName
        socialRequest.email = email
        
        NetworkServiceLogic.genericNetworkRequest(params: socialRequest, responseObject: LoginResponse(), requestMethod: .post, showAlert: false, requestURL: NetworkConstants.API.socialLogin) { responseObject in
            
            if let response = responseObject, let responseData = response.data?.first {
                print("The token is: \(responseData.access_token ?? "")")
                KeyChainPreference.shared.save(key: KeyChainKey.authToken.rawValue, value: responseData.access_token ?? "")
                UserPreference.shared.setIntForKey(responseData.user?.id ?? 0, key: UserPreferenceAppInfoData.userId.rawValue)
                completion(true)
            }
        }
    }
}
