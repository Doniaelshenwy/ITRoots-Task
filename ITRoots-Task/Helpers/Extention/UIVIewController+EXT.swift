//
//  UIVIewController+EXT.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 27/01/2025.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    
    func push(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func isNavigationHidden(_ status: Bool) {
        navigationController?.isNavigationBarHidden = status
    }
    
    func isTabBarHidden(_ status: Bool){
        tabBarController?.tabBar.isHidden = status
    }
}

extension UIViewController {
    func openTabBar() {
        self.view.window?.rootViewController = TabBarController()
    }
}
