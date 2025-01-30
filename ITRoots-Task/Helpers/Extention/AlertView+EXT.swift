//
//  AlertView+EXT.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 27/01/2025.
//

import UIKit
import CDAlertView

extension UIViewController {
    func makeOkAlert(title: String, SubTitle: String = "", Image : UIImage = UIImage()) {
        let alert = CDAlertView(title: title, message: SubTitle, type: .notification)
        let doneAction = CDAlertViewAction(title: "Ok".localize)
        alert.circleFillColor = UIColor(named: "appColor")!
        doneAction.buttonTextColor = UIColor(named: "appColor")!
        alert.add(action: doneAction)
        alert.show()
    }
    
    func makeAlertWithTwoButtons(
        title: String,
        message: String,
        okCompletion: (() -> Void)? = nil,
        cancelCompletion: (() -> Void)? = nil
    ) {
        let alert = CDAlertView(title: title, message: message, type: .notification)
        let okAction = CDAlertViewAction(title: "Ok".localize) { (action) -> Bool in
            okCompletion?()
            return true
        }
        let cancelAction = CDAlertViewAction(title: "Cancel".localize) { (action) -> Bool in
            cancelCompletion?()
            return true
        }
        alert.circleFillColor = UIColor(named: "appColor")
        okAction.buttonTextColor = UIColor(named: "appColor")
        cancelAction.buttonTextColor = UIColor(named: "appColor")
        alert.add(action: okAction)
        alert.add(action: cancelAction)
        alert.show()
    }
}
