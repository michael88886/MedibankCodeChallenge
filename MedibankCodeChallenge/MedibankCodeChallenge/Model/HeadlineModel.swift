//  Copyright © 2020 Michael.H. All rights reserved.

import UIKit

struct HeadlineModel {
    let articles: [ArticleItem]
    let errorMessage: String?
}

struct ArticleItem {
    let title: String
    let description: String?
    let thumbnailUrl: String?
    let url: String
    let author: String?
    let sourceId: String
    let sourceName: String
}
