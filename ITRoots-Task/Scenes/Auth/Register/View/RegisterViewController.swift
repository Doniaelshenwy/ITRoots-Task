//
//  RegisterViewController.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 29/01/2025.
//

import UIKit

final class RegisterViewController: BaseViewController {
    
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordSecureButton: UIButton!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var fullNameTextField: UITextField!
    
    private var isPasswordVisible = false
    private let viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isNavigationHidden(false)
    }
    
    func setupViews() {
        [phoneTextField, emailTextField, passwordTextField, userNameTextField, fullNameTextField].forEach { $0?.setAlignment() }
        phoneTextField.delegate = self
        bindUI()
    }
    
    @IBAction private func didTapPasswordSecure(_ sender: Any) {
        isPasswordVisible.toggle()
        passwordTextField.isSecureTextEntry = !isPasswordVisible
        let eyeImg = isPasswordVisible ? UIImage(named: "eye-on") : UIImage(named: "eye-off")
        passwordSecureButton.setImage(eyeImg, for: .normal)
    }
    
    @IBAction private func didTapSignIn(_ sender: Any) {
        pop()
    }
    
    @IBAction private func didTapSignUp(_ sender: Any) {
        viewModel.register(RegisterModel(
            fullName: fullNameTextField.text ?? "",
            userName: userNameTextField.text ?? "",
            password: passwordTextField.text ?? "",
            email: emailTextField.text ?? "",
            phone: phoneTextField.text ?? ""
        ))
    }
}

// MARK: Handle Phone Length
extension RegisterViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == phoneTextField else { return true }
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= 10
    }
}

// MARK: UI BIND
private extension RegisterViewController {
    
    func bindUI() {
        bindShowAlert()
        bindIsSuccessLogin()
    }
    
    func bindShowAlert() {
        viewModel.$showAlert.sink { [weak self] text in
            guard let self, let text else { return }
            self.makeOkAlert(title: text)
        }.store(in: &cancellable)
    }
    
    func bindIsSuccessLogin() {
        viewModel.$isSuccessRegister.sink { [weak self] success in
            guard let self, success else { return }
            Utilities.utilities.addIsLogin(isLogin: true)
            openTabBar()
        }.store(in: &cancellable)
    }
}
