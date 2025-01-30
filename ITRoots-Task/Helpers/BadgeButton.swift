//
//  BadgeButton.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 28/01/2025.
//

import Foundation
import UIKit

class BadgeButton: UIButton {
    
    var badgeLabel = UILabel()
    
    public var badgeBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) {
        didSet {
            badgeLabel.backgroundColor = badgeBackgroundColor
        }
    }
    
    public var badgeTextColor = UIColor(named: "appColor")! {
        didSet {
            badgeLabel.textColor = badgeTextColor
        }
    }
    
    public var badgeFont = UIFont.systemFont(ofSize: 12.0) {
        didSet {
            badgeLabel.font = badgeFont
        }
    }
}
