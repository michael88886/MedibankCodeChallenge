//  Copyright © 2020 Michael.H. All rights reserved.

import UIKit

class SourceCell: UITableViewCell {

    private enum Constant {
        static let shadowOpacity: Float = 0.4
        static let shadowRadius: CGFloat = 3.0
    }
    
    // MARK: - IBOutlet
    /// The flag label background
    @IBOutlet private var flagBackgroundView: UIView! {
        didSet {
            flagBackgroundView.layer.shadowColor = UIColor.black.cgColor
            flagBackgroundView.layer.shadowOpacity = Constant.shadowOpacity
            flagBackgroundView.layer.shadowOffset = .zero
            flagBackgroundView.layer.shadowRadius = Constant.shadowRadius
        }
    }
    
    /// The index letter label
    @IBOutlet private var flagLabel: UILabel!
    
    /// The source name label
    @IBOutlet private var sourceNameLabel: UILabel!
    
    /// The source url label
    @IBOutlet private var sourceLinkLabel: UILabel!

    /// The check mark image view
    @IBOutlet private var checkMarkImageView: UIImageView!
    
    // MARK: Overrides
    override func prepareForReuse() {
        super.prepareForReuse()
        flagLabel.text = ""
        sourceNameLabel.text = ""
        sourceLinkLabel.text = ""
        checkMarkImageView.isHidden = true
    }
    
        
    // MARK: - Funtions
    func updateCell(data: SourceItem) {
        flagLabel.text = data.countryFlag
        sourceNameLabel.text = data.name
        sourceLinkLabel.text = data.link
        checkMarkImageView.isHidden = !data.selected
    }
}
