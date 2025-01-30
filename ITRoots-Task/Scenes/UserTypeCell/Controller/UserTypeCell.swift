

import UIKit
import DropDown

final class UserTypeCell: DropDownCell {

    @IBOutlet private weak var countryImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        countryImage.isHidden = true
    }
}
