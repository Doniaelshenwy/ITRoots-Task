//
//  RegisterViewModel.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 29/01/2025.
//

import Foundation

final class RegisterViewModel {
    
    @Published var showAlert: String?
    @Published var isSuccessRegister = false

    func register(_ model: RegisterModel) {
        guard let fullName = model.fullName, (fullName.count > 2) else {
            showAlert = "Please Enter Your Valid Full Name".localize
            return
        }
        guard let userName = model.userName, (userName.count > 2) else {
            showAlert = "Please Enter Your Valid UserName".localize
            return
        }
        guard let password = model.password, (password.count > 5) else {
            showAlert = "Please Enter Your Password Greater Than or Equal 6".localize
            return
        }
        guard let email = model.email, email.isValidEmail() else {
            showAlert = "Please enter a valid email".localize
            return
        }
        guard let phone = model.phone, phone.count == 10 else {
            showAlert = "\("Please enter a valid mobile number that contain".localize) \(10) \("digits".localize)".localize
            return
        }
        isSuccessRegister = true
    }
}
