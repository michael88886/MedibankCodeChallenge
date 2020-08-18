//  Copyright © 2020 Michael.H. All rights reserved.

import UIKit

class HeadlineCell: UITableViewCell {

    private enum Constant {
        static let shadowOpacity: Float = 0.2
        static let shadowRadius: CGFloat = 4.0
        static let descSpacing: CGFloat = 10
    }
    
    // MARK: - IBOutlet
    @IBOutlet private var headlineWrapper: UIView! {
        didSet {
            headlineWrapper.layer.shadowColor = UIColor.black.cgColor
            headlineWrapper.layer.shadowOpacity = Constant.shadowOpacity
            headlineWrapper.layer.shadowRadius = Constant.shadowRadius
            headlineWrapper.layer.shadowOffset = .zero
        }
    }
    @IBOutlet private var headlineStackView: UIStackView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var sourceLabel: UILabel!
    @IBOutlet private var authorLabel: UILabel!
    @IBOutlet private var thumbnailImage: UIImageView!
    
    
    // MARK: - Overrides
    override func awakeFromNib() {
        headlineStackView.setCustomSpacing(Constant.descSpacing, after: sourceLabel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        descriptionLabel.text = ""
        authorLabel.text = ""
        sourceLabel.text = ""
        thumbnailImage.image = nil
    }

    // MARK: - Functions
    func updateCell(data: ArticleItem) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        sourceLabel.text = "Source: " + data.sourceName
        if let author = data.author {
            authorLabel.text = "Author: " + author
        }
    }
    
    func updateThumbnail(_ image: UIImage) {
        thumbnailImage.image = image
    }
}
