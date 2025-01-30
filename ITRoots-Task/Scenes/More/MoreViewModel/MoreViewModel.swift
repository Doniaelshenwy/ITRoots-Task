//
//  MoreViewModel.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 29/01/2025.
//

import Foundation

final class MoreViewModel {
    
    @Published var isLoading = false
    @Published var isReloadTableView = false
    @Published var showAlert: String?
    
    var postsData: [PostsResponse] = []
    let network: NetworkProtocol = NetworkManager()
    
    // MARK: Get Data From API
    func getMoreDataRequest() {
        guard InternetManager().isConnect else {
            getLocalMoreData()
            return
        }
        isLoading = true
        let request = AppEndPoints.getPosts
        network.fetchData(endPoint: request, response: [PostsResponse].self) { [weak self] result in
            guard let self else { return }
            isLoading = false
            switch result {
            case .success(let data):
                postsData = data
                saveMoreToUserDefaults(item: data)
                isReloadTableView = true
            case .failure(let error):
                showAlert = error.localizedDescription
            }
        }
    }
}


// MARK: saved mine competition
extension MoreViewModel {
    func saveMoreToUserDefaults(item: [PostsResponse]?) {
        do {
            let data = try JSONEncoder().encode(item)
            UserDefaults.standard.set(data, forKey: "MoreResponse")
        } catch {
            print("Failed to save item: \(error)")
        }
    }
    
    var loadMoreFromUserDefaults: [PostsResponse]? {
        guard let data = UserDefaults.standard.data(forKey: "MoreResponse") else { return nil }
        do {
            return try JSONDecoder().decode([PostsResponse].self, from: data)
        } catch {
            print("Failed to load item: \(error)")
            return nil
        }
    }
    
    func removeMoreFromUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "MoreResponse")
    }
    
    func getLocalMoreData() {
        guard let loadMoreFromUserDefaults else { return }
        print("Loaded Item: \(loadMoreFromUserDefaults)")
        postsData = loadMoreFromUserDefaults
        isReloadTableView = true
    }
}

