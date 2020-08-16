//  Copyright © 2020 Michael.H. All rights reserved.

import Foundation

enum AppError: Error {
    
    case invalidUrl
    case networkServiceFailed
    case decodeError
    case failedFetchSource
    
    func message() -> String {
        switch self {
        case .invalidUrl:
            return "Invalid URL."
        case .networkServiceFailed:
            return "Network service failed."
        case .decodeError:
            return "Decode Error."
        case .failedFetchSource:
            return "Failed to fetch headline souces."
        }
    }
}
