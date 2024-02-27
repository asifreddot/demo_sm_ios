//
//  CreateAccountRequest.swift
//  smart to do
//
//  Created by Asif Reddot on 25/2/24.
//

import Foundation

struct CreateAccountRequest: Entity {
    var name: String?
    var email: String?
    var password: String?
    var role: String?
}
