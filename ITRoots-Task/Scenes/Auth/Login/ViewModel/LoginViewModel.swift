//
//  LoginViewModel.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 29/01/2025.
//

import Foundation

final class LoginViewModel {
    
    @Published var showAlert: String?
    @Published var isSuccessLogin = false
    
    var userTypeData = ["Admin".localize, "User".localize]

    func login(_ model: LoginModel) {
        guard let name = model.userName, name.count > 2 else {
            showAlert = "Please Enter Your Valid UserName".localize
            return
        }
        guard let password = model.password, !(password.isEmpty) else {
            showAlert = "Please Enter Your Password".localize
            return
        }
        guard let userType = model.userType, !(userType.isEmpty) else {
            showAlert = "Please Enter Your User Type".localize
            return
        }
        isSuccessLogin = true
    }
}
