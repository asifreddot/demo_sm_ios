//
//  TaskStatus.swift
//  smart to do
//
//  Created by Asif Reddot on 26/2/24.
//

import Foundation

struct TaskStatusResponse: Entity {
    var id: Int?
    var status: String?
}

struct TaskUpdateResponse: Entity {
    var title: String?
    var description: String?
    var user_id: Int?
}

struct TaskDeleteResponse: Entity {
    var success: String?
}
