//  Copyright © 2020 Michael.H. All rights reserved.

import Foundation

enum AppError: Error {
    case failedFetchSource
    
    func message() -> String {
        switch self {
        case .failedFetchSource:
            return "Failed to fetch headline souces."
        }
    }
}
