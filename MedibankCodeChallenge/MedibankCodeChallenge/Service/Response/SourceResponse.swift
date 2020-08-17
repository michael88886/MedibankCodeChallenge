//  Copyright © 2020 Michael.H. All rights reserved.

import Foundation

struct SourceResponse: BaseResponse, ErrorRespones, Decodable {
    var status: String
    var code: String?
    var message: String?
    var sources: [SourceItemResponse]?
}

struct SourceItemResponse: Decodable {
    let id: String
    let name: String
    let description: String
    let url: String
    let category: String
    let language: String
    let country: String
}
