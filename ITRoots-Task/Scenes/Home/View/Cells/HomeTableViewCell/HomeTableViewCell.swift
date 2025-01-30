//
//  HomeTableViewCell.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 27/01/2025.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {

    @IBOutlet private weak var homePriceLabel: UILabel!
    @IBOutlet private weak var homeNameLabel: UILabel!
    @IBOutlet private weak var homeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configureCell(data: VerticalDataModel) {
        homeImage.image = UIImage(named: data.image)
        homePriceLabel.text = data.price
        homeNameLabel.text = data.title.localize
    }
}
