//
//  NetworkServiceLogic.swift
//  smart to do
//
//  Created by Asif Reddot on 25/2/24.
//

import Foundation

public class NetworkServiceLogic: NSObject {
    static public func genericNetworkRequest<T: Entity>(params: Entity?, responseObject: T, requestMethod: RequestMethod, showAlert: Bool, requestURL: String, showLoader: Bool = true, _ completion: @escaping(_ object: GenericResponse<T>?) -> Void) {
        
        NetworkService.sharedInstance.load(path: requestURL, method: requestMethod, params: params?.json ?? JSON(), showLoader: showLoader, completion: {(data, httpStatusCode) in
            
            if handleResponseWithCorrespondingHTTPStatusCode(data: data, statusCode: httpStatusCode, showAlert: showAlert) {
                var parsedData: GenericResponse<T>?
                
                var baseData: BaseResponse?
                baseData = try? JSONDecoder().decode(BaseResponse.self, from: data!)
                
                if let responseData = data {
                    print(GenericResponse<T>.self)
                    do{
                        parsedData = try JSONDecoder().decode(GenericResponse.self, from: responseData)
                    } catch {
                        if showAlert {
                            
                        }
                    }
                    completion(parsedData)
                }
            }
        })
    }
    
    static public func genericNetworkRequestForBaseResponse<T: Entity>(params: Entity?, responseObject: T,requestMethod: RequestMethod,showAlert: Bool, requestURL: String, _ completion: @escaping(_ object: T?, _ failure: BaseResponse?) -> Void) {

        NetworkService.sharedInstance.load(path: requestURL, method: requestMethod, params: params?.json ?? JSON(), completion: {(data, httpStatusCode) in

            if handleResponseWithCorrespondingHTTPStatusCode(data: data, statusCode: httpStatusCode, showAlert: showAlert) {
                var parsedData: T?
                parsedData = try? JSONDecoder().decode(T.self, from: data!)

                if let responseData = data {
                    parsedData = try? JSONDecoder().decode(T.self, from: responseData)
                    completion(parsedData, nil)
                }
            }
        })

    }
}

//MARK: Handle Response
extension NetworkServiceLogic {
    static public func handleResponseWithCorrespondingHTTPStatusCode(data: Data?, statusCode: Int, showAlert: Bool) -> Bool {
        if (statusCode >= 200) && (statusCode <= 299) {
            return true
            
        } else {
            return false
        }
    }
}
