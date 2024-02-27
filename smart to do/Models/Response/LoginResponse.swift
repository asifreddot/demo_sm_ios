//
//  LoginResponse.swift
//  smart to do
//
//  Created by Asif Reddot on 26/2/24.
//

import Foundation

struct LoginResponse: Entity {
    var access_token: String?
    var token_type: String?
    var user: User?
}
