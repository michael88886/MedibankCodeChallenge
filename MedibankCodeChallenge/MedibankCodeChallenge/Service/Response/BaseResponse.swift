//  Copyright © 2020 Michael.H. All rights reserved.

import Foundation

protocol BaseResponse {
    var status: String { get }
}

protocol ErrorRespones {
    var code: String? { get }
    var message: String? { get }
}
