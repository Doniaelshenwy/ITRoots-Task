//
//  MoreViewController.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 29/01/2025.
//

import UIKit

final class MoreViewController: BaseViewController {
    
    @IBOutlet private weak var moreTableView: UITableView!
    
    private var logout = BadgeButton()
    private var language = BadgeButton()
    private let viewModel = MoreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getMoreDataRequest()
    }
    
    private func setupViews() {
        navigationItem.title = "More".localize
        setTableView()
        addrightBarButtonItem()
        addLefttBarButtonItem()
        bindUI()
    }
}

// MARK: Setup UITableView Delegate and DataSource
extension MoreViewController: TableViewConfig {
    
    func setTableView() {
        moreTableView.delegate = self
        moreTableView.dataSource = self
        moreTableView.registerCellNib(cellClass: MoreTableViewCell.self)
        moreTableView.showsVerticalScrollIndicator = false
        moreTableView.showsHorizontalScrollIndicator = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.postsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(with: MoreTableViewCell.self, for: indexPath)
        cell.configureCell(data: viewModel.postsData[indexPath.row])
        return cell
    }
}

// MARK: Setup Logout Button In Navigation
private extension MoreViewController {
    func addrightBarButtonItem() {
        logout.frame = CGRect(x: 20, y: 0, width: 20, height: 20)
        logout.tintColor = .black
        logout.setImage(UIImage(named: "logout"), for: .normal)
        logout.contentMode = .scaleAspectFit
        logout.addTarget(self, action: #selector(clickOnLogoutButton), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logout)
    }
    
    @objc func clickOnLogoutButton() {
        setLogoutAlert()
    }
    
    func setLogoutAlert() {
        makeAlertWithTwoButtons(
            title: "Are you sure you want to logout?".localize,
            message: "",
            okCompletion: { [weak self] in
                guard let self else { return }
                Utilities.utilities.addIsLogin(isLogin: false)
                self.viewModel.removeMoreFromUserDefaults()
                self.goToRootLoginVC()
            },
            cancelCompletion: {}
        )
    }
    
    func goToRootLoginVC() {
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

// MARK: Setup Change Language Button In Navigation
private extension MoreViewController {
    func addLefttBarButtonItem() {
        language.frame = CGRect(x: 20, y: 0, width: 20, height: 20)
        language.tintColor = .black
        language.setImage(UIImage(named: "language"), for: .normal)
        language.contentMode = .scaleAspectFit
        language.addTarget(self, action: #selector(clickOnLanguageButton), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: language)
    }
    
    @objc func clickOnLanguageButton() {
        changeLanguage()
    }
    
    func changeLanguage() {
        let isArabic = L102Language.isRTL
        L102Language.setAppleLAnguageTo(lang: isArabic ? "en" : "ar")
        LanguageManager.shared.setLanguage(language: isArabic ? .en : .ar)
        UIView.appearance().semanticContentAttribute = isArabic ? .forceLeftToRight : .forceRightToLeft
        Bundle.setLanguage(L102Language.currentAppleLanguage())
        openTabBar()
    }
}

// MARK: UI BIND
private extension MoreViewController {
    func bindUI() {
        bindStartIndicator()
        bindShowOkAlert()
        reloadTableView()
    }
    
    func bindStartIndicator() {
        viewModel.$isLoading.sink { [weak self] start in
            guard let self else { return }
            start ? self.activityIndicatorView.startAnimating() : self.activityIndicatorView.stopAnimating()
        }.store(in: &cancellable)
    }
    
    func bindShowOkAlert() {
        viewModel.$showAlert.sink { [weak self] text in
            guard let self, let text else { return }
            self.makeOkAlert(title: text)
        }.store(in: &cancellable)
    }
    
    func reloadTableView() {
        viewModel.$isReloadTableView.sink { [weak self] reload in
            guard let self, reload else { return }
            self.moreTableView.reloadData()
        }.store(in: &cancellable)
    }
}
