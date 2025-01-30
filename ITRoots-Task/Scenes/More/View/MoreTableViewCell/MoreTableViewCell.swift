//
//  MoreTableViewCell.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 28/01/2025.
//

import UIKit

final class MoreTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configureCell(data: PostsResponse) {
        titleLabel.text = data.title
        descriptionLabel.text = data.body
    }
}
