//
//  BaseViewController.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 27/01/2025.
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController {
    
    private var frame = CGRect()
    var activityIndicatorView = NVActivityIndicatorView(frame: CGRect())
    var cancellable = Cancellable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpActivityIndicator()
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideKeyboardWhenTappedAround()
        setUpNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.setNeedsLayout()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
}

private extension BaseViewController {
    
    func setUpActivityIndicator() {
        frame = CGRect(x: self.view.frame.width / 2 , y: self.view.frame.height / 2, width: 0, height: 0)
        activityIndicatorView = NVActivityIndicatorView(frame: frame, type: .ballScale)
        activityIndicatorView.color = .app
        activityIndicatorView.padding = 100
        self.view.addSubview(activityIndicatorView )
    }
    
    func setUpNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        let backItemAppearance = UIBarButtonItemAppearance()
        backItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear] // Fix text color
        appearance.backButtonAppearance = backItemAppearance
        
        var image = UIImage(named: "arrow-left")!.withRenderingMode(.alwaysOriginal)
        if L102Language.isRTL {
            image = image.withHorizontallyFlippedOrientation()
        }
        appearance.setBackIndicatorImage(image, transitionMaskImage: image)
        UINavigationBar.appearance().tintColor = UIColor.black
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "blackColor") ?? .black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)
        ]
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        self.navigationController?.navigationBar.setNeedsLayout()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
