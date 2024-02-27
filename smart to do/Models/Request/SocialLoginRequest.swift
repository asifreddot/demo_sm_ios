//
//  SocialLoginRequest.swift
//  smart to do
//
//  Created by Asif Reddot on 27/2/24.
//

import Foundation

struct SocialLoginRequest: Entity {
    var provider_id: String?
    var name: String?
    var email: String?
}
