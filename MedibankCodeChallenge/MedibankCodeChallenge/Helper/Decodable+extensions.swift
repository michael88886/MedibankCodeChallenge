//  Copyright © 2020 Michael.H. All rights reserved.

import Foundation

extension Decodable {
    static func decode(jsonData: Data) throws -> Self {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let object: Self = try decoder.decode(self, from: jsonData)
        return object
    }
}
