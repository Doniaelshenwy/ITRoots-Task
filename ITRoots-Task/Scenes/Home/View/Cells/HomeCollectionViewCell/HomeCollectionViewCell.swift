//
//  HomeCollectionViewCell.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 27/01/2025.
//

import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var homeBGView: UIView!
    @IBOutlet private weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(data: HorizontalDataModel) {
        textLabel.text = data.title.localize
        homeBGView.borderColor = data.isSelected ? .app : .border
    }
}
