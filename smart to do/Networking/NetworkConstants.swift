//
//  NetworkConstants.swift
//  smart to do
//
//  Created by Asif Reddot on 25/2/24.
//

import Foundation

class NetworkConstants {
    static let baseUrl = "https://smartpoc.leanhr.app/"
    
    struct API {
        static let createAccount = "api/auth/register"
        static let login = "api/auth/login"
        static let socialLogin = "api/auth/social"
        static let taskList = "api/task/list"
        static let taskDelete = "api/task/change-status"
        static let taskAdd = "api/task/batch-create"
        static let taskUpdate = "api/task/update"
    }
}

public enum RequestMethod: String {
    case get                                                = "GET"
    case post                                               = "POST"
    case put                                                = "PUT"
    case delete                                             = "DELETE"
}
