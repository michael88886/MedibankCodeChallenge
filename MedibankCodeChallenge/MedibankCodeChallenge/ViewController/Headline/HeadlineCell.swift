//  Copyright © 2020 Michael.H. All rights reserved.

import UIKit

class HeadlineCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private var headlineWrapper: UIView! {
        didSet {
            headlineWrapper.layer.shadowColor = UIColor.black.cgColor
            headlineWrapper.layer.shadowOpacity = 0.2
            headlineWrapper.layer.shadowRadius = 4.0
            headlineWrapper.layer.shadowOffset = .zero
        }
    }
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var sourceLabel: UILabel!
    @IBOutlet private var authorLabel: UILabel!
    @IBOutlet private var thumbnailImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        descriptionLabel.text = ""
        authorLabel.text = ""
        sourceLabel.text = ""
        thumbnailImage.image = nil
    }

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
