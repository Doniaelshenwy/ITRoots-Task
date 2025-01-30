//
//  AppEndPoints.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 29/01/2025.
//

import Alamofire

enum AppEndPoints {
    case getPosts
}

extension AppEndPoints: Endpoint {

    var path: String {
        switch self {
        case .getPosts:
            return "/posts"
        }
    }
    
    var method: HttpMethod {
        .GET
    }
    
    var task: Task {
        .requestPlain
    }
    
    var headers: [String : String] {
        [:]
    }
}
