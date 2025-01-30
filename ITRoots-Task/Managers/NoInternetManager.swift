//
//  NoInternetManager.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 28/01/2025.
//

import Foundation

final class InternetManager {
    
    var isConnect: Bool {
        hasInternetConnectivity()
    }
    
    private func hasInternetConnectivity() -> Bool {
        guard let url = URL(string: "https://www.google.com") else { return false }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 1)
        let semaphore = DispatchSemaphore(value: 0)
        var success = false

        URLSession(configuration: .default).dataTask(with: request) { _, response, error in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, error == nil {
                success = true
            }
            semaphore.signal()
        }.resume()

        semaphore.wait()
        return success
    }
}
