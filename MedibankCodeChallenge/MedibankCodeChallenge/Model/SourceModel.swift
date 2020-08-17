//  Copyright © 2020 Michael.H. All rights reserved.

import Foundation

struct SourceModel {
    let sources: [SourceItem]
    let errorMessage: String?
}

struct SourceItem {
    let id: String
    let name: String
    let link: String
    let countryFlag: String
    var selected: Bool
}
