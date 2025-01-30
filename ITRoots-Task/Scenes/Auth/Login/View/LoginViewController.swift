//
//  LoginViewController.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 29/01/2025.
//

import UIKit
import DropDown

final class LoginViewController: BaseViewController {
    
    @IBOutlet private weak var userTypeButton: UIButton!
    @IBOutlet private weak var userTypeTextField: UITextField!
    @IBOutlet private weak var passowrdSecureButton: UIButton!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var userNameTextField: UITextField!
    
    private var isPasswordVisible = false
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isNavigationHidden(true)
    }
    
    func setupViews() {
        [userNameTextField, passwordTextField, userTypeTextField].forEach { $0?.setAlignment() }
        bindUI()
    }
    
    @IBAction private func didTapPasswordSecure(_ sender: Any) {
        isPasswordVisible.toggle()
        passwordTextField.isSecureTextEntry = !isPasswordVisible
        let eyeImg = isPasswordVisible ? UIImage(named: "eye-on") : UIImage(named: "eye-off")
        passowrdSecureButton.setImage(eyeImg, for: .normal)
    }
    
    @IBAction private func didTapUserType(_ sender: Any) {
        dropDownUserType()
    }
    
    @IBAction private func didTapLogin(_ sender: Any) {
        viewModel.login(LoginModel(
            userName: userNameTextField.text ?? "",
            password: passwordTextField.text ?? "",
            userType: userTypeTextField.text ?? ""
        ))
    }
    
    @IBAction private func didTapLanguage(_ sender: Any) {
        changeLanguage()
    }
    
    @IBAction private func didTapRegister(_ sender: Any) {
        push(RegisterViewController())
    }
}

private extension LoginViewController {
    
    func changeLanguage() {
        let isArabic = L102Language.isRTL
        L102Language.setAppleLAnguageTo(lang: isArabic ? "en" : "ar")
        LanguageManager.shared.setLanguage(language: isArabic ? .en : .ar)
        UIView.appearance().semanticContentAttribute = isArabic ? .forceLeftToRight : .forceRightToLeft
        Bundle.setLanguage(L102Language.currentAppleLanguage())
        restartApplication()
    }
    
    func restartApplication() {
        Bundle.setLanguage(L102Language.currentAppleLanguage())
        DispatchQueue.main.async {
            let keyWindow = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
            keyWindow?.rootViewController = UINavigationController(rootViewController: LoginViewController())
            keyWindow?.makeKeyAndVisible()
        }
    }
}

// MARK: Setup DropDown
private extension LoginViewController {
    func dropDownUserType() {
        let dropDown = DropDown()
        dropDown.backgroundColor = .white
        dropDown.anchorView = userTypeButton
        if L102Language.isRTL {
            DropDown.appearance().semanticContentAttribute = .forceLeftToRight
        }
        var array = [String]()
        let count = viewModel.userTypeData.count
        for e in 0..<count {
            array.append(viewModel.userTypeData[e])
        }
        dropDown.dataSource = array
        dropDown.cellNib = UINib(nibName: "UserTypeCell", bundle: nil)
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? UserTypeCell else { return }
            cell.optionLabel.text = array[index]
        }
        dropDown.show()
        dropDown.selectionAction = { [weak self] index, _ in
            guard let self else { return }
            self.userTypeTextField.text = viewModel.userTypeData[index]
        }
    }
}

// MARK: UI BIND
private extension LoginViewController {
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
        viewModel.$isSuccessLogin.sink { [weak self] success in
            guard let self, success else { return }
            Utilities.utilities.addIsLogin(isLogin: true)
            openTabBar()
        }.store(in: &cancellable)
    }
}
