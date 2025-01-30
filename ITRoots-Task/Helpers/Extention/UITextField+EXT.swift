//
//  UITextField+EXT.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 27/01/2025.
//

import UIKit

extension UITextField {
    func setAlignment() {
        self.textAlignment = L102Language.isRTL ? .right : .left
    }
}
