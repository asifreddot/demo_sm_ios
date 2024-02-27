//
//  TaskListResponse.swift
//  smart to do
//
//  Created by Asif Reddot on 26/2/24.
//

import Foundation

struct TaskListResponse: Entity {
    var currentPage: Int?
    var data: [Task]?
    var firstPageURL: String?
    var from: Int?
    var lastPage: Int?
    var lastPageURL: String?
    var links: [Link]?
}

struct Task: Entity {
    var id: Int?
    var title: String?
    var description: String?
    var sync_id: String?
    var status: String?
    var userID: Int?
}

struct Link: Entity {
    var url: String?
    var label: String?
    var active: Bool?
}
