//
//  HorizontalDataModel.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 27/01/2025.
//

import Foundation

class HorizontalDataModel {
    var title: String
    var isSelected: Bool
    
    init(title: String, isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
    }
}
