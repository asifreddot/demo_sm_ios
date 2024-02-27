//
//  User.swift
//  smart to do
//
//  Created by Asif Reddot on 26/2/24.
//

import Foundation

struct User: Entity {
    var id: Int?
    var name: String?
    var email: String?
    var email_verified_at: String? // Change the type accordingly
    var phone: String? // Change the type accordingly
    var avatar: String? // Change the type accordingly
    var provider_id: String? // Change the type accordingly
    var role: String?
    var created_at: String?
    var updated_at: String?
}
