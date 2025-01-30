//
//  MoreResponse.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 28/01/2025.
//

import Foundation

struct PostsResponse: Codable {
    var userID, id: Int?
    var title, body: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
