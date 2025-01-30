//
//  NetworkProtocol.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 28/01/2025.
//

import UIKit

protocol NetworkProtocol {
    func fetchData<T: Endpoint, M: Codable>(endPoint: T, response: M.Type, completion: @escaping(Result<M, ErrorMessage>) -> Void)
}
