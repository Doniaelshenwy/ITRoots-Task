//
//  VerticalDataModel.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 27/01/2025.
//

import Foundation

class VerticalDataModel {
    var title: String
    var image: String
    var price: String
    
    init(title: String, image: String, price: String) {
        self.title = title
        self.image = image
        self.price = price
    }
}

extension VerticalDataModel {
    static var items: [VerticalDataModel] {
        let data: [VerticalDataModel] = [
            .init(title: "Walk Safety Hat (1X)", image: "home-image", price: "BD 200"),
            .init(title: "Looks like you have items from a different Store in your cart.", image: "image1", price: "BD 1000"),
            .init(title: "Walk Safety Hat (1X)", image: "image2", price: "BD 200"),
            .init(title: "Walk Safety Hat (1X)", image: "home-image", price: "BD 200"),
            .init(title: "Looks like you have items from a different Store in your cart.", image: "image4", price: "BD 1000"),
            .init(title: "Walk Safety Hat (1X)", image: "home-image", price: "BD 200"),
            .init(title: "Looks like you have items from a different Store in your cart.", image: "image1", price: "BD 1000"),
            .init(title: "Walk Safety Hat (1X)", image: "image2", price: "BD 200"),
            .init(title: "Walk Safety Hat (1X)", image: "home-image", price: "BD 200"),
            .init(title: "Walk Safety Hat (1X)", image: "home-image", price: "BD 200"),
            .init(title: "Looks like you have items from a different Store in your cart.", image: "image1", price: "BD 1000"),
            .init(title: "Walk Safety Hat (1X)", image: "image2", price: "BD 200"),
            .init(title: "Walk Safety Hat (1X)", image: "home-image", price: "BD 200"),
            .init(title: "Looks like you have items from a different Store in your cart.", image: "image4", price: "BD 1000")
        ]
        return data
    }
}
