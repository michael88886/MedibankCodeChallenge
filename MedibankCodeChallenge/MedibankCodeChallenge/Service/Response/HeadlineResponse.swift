//  Copyright © 2020 Michael.H. All rights reserved.

import Foundation

struct HeadlineResponse: BaseResponse, ErrorRespones, Decodable {
    var status: String
    var code: String?
    var message: String?
    var totalResults: Int?
    var articles: [Article]?
}

struct Article: Decodable {
    var source: HeadlineSource
    var author: String
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    var content: String
}

struct HeadlineSource: Decodable {
    let id: String
    let name: String
}
