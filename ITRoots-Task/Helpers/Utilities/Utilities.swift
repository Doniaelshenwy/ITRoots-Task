//
//  Utilities.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 27/01/2025.
//

import UIKit

class Utilities {
    static let utilities = Utilities()
    
    func addIsLogin(isLogin: Bool) {
        UserDefaults.standard.set(isLogin, forKey: "isLogin")
    }
    
    func getIsLogin() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLogin")
    }
}
