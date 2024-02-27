//
//  NetworkService.swift
//  smart to do
//
//  Created by Asif Reddot on 25/2/24.
//

import UIKit
import Foundation

final public class NetworkService: NSObject {
    private var baseUrl: String = NetworkConstants.baseUrl
    private var urlSession = URLSession(configuration: URLSessionConfiguration.default)
    private var apiTasks: [URLSessionTask] = []
    private var requestTimeoutValue: Double = 60.0
    public static let sharedInstance = NetworkService()

    private override init() {
        self.baseUrl = NetworkConstants.baseUrl
    }
}

//MARK: Request Methods
extension NetworkService {
    func load(path: String, method: RequestMethod, params: JSON, showLoader: Bool = true, completion: @escaping (Data?, Int) -> Void) -> Void {
        
        NetworkService.sharedInstance.urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        
        var request = URLRequest(baseUrl: self.baseUrl, path: path, method: method, params: params)
        request.timeoutInterval = requestTimeoutValue
        
        print("\nSERVICE CALLING STARTED.........\n")
        print(request.url ?? "")
        print(params)
        let task = NetworkService.sharedInstance.urlSession.dataTask(with: request) { data, response, error in
            self.apiTaskDone()
            
            if let requestData = data {
                if let json = try? JSONSerialization.jsonObject(with: requestData, options: []) {
                    print(json)
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("statusCode: \(httpResponse.statusCode)")
                    completion(requestData, httpResponse.statusCode)
                }
            } else {
                if let error = error as NSError? {
                    
                }
            }
        }
        NetworkService.sharedInstance.apiTasks.append(task)
        task.resume()
        
        return
    }
}

// MARK: URL session delegate
extension NetworkService: URLSessionDelegate {
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

        completionHandler(
                    .useCredential,
                    URLCredential(trust: challenge.protectionSpace.serverTrust!)
                )
    }
}

//MARK: Custom methods
extension NetworkService {

    func apiTaskDone() {
        if apiTasks.count > 0 {
            apiTasks.removeLast()
        }
    }

    func cancelAllAPICalls() {
        for task in apiTasks {
            task.cancel()
        }
        apiTasks.removeAll()
    }
}

//MARK: URL
extension URL {
    init(baseUrl: String, path: String, params: JSON, method: RequestMethod) {
        var components = URLComponents(string: baseUrl)
        components?.path += path

        switch method {
        case .get, .delete:
            components?.queryItems = params.map {
                URLQueryItem(name: $0.key, value: String(describing: $0.value))
            }
        default:
            break
        }

        if let url = components?.url {
            self = url
        } else {
            self = URL(fileURLWithPath: "")
        }
    }
}

//MARK: URLRequest
extension URLRequest {
    init(baseUrl: String, path: String, method: RequestMethod, params: JSON) {
        let url = URL(baseUrl: baseUrl, path: path, params: params, method: method)
        let token = KeyChainPreference.shared.loadKeyChainString(forKey: KeyChainKey.authToken.rawValue)

        self.init(url: url)
        httpMethod = method.rawValue
        setValue("application/json", forHTTPHeaderField: "Accept")
        setValue("application/json", forHTTPHeaderField: "Content-Type")
        setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        switch method {
        case .post, .put:
            httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
        default:
            break
        }
    }
}
