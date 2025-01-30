//
//  HomeViewModel.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 29/01/2025.
//

import Foundation

final class HomeViewModel {
    
    @Published var reloadIsArabicHomeCollectionView: Bool?
    @Published var isScrollHorizontalCollectionView: Int?
    
    var verticalData = VerticalDataModel.items
    
    var horizontalDataArray = [
        HorizontalDataModel(title: "Car seats"),
        HorizontalDataModel(title: "Strollers"),
        HorizontalDataModel(title: "Clothing"),
        HorizontalDataModel(title: "Accessories"),
        HorizontalDataModel(title: "Car seats"),
        HorizontalDataModel(title: "Strollers"),
        HorizontalDataModel(title: "Clothing"),
        HorizontalDataModel(title: "Accessories")
    ]
    
    func handleHorizontalDataArray() {
        horizontalDataArray.forEach { $0.isSelected = false }
        if L102Language.isRTL {
            horizontalDataArray.reverse()
            horizontalDataArray.last?.isSelected = true
            reloadIsArabicHomeCollectionView = true
        } else {
            horizontalDataArray.first?.isSelected = true
            reloadIsArabicHomeCollectionView = false
        }
    }
    
    func selectedHorizontalDataArray(index: Int) {
        horizontalDataArray.forEach { $0.isSelected = false }
        horizontalDataArray[index].isSelected = true
        isScrollHorizontalCollectionView = index
    }
}
