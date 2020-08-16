//  Copyright © 2020 Michael.H. All rights reserved.

import Foundation

struct SourceViewModel {

    // MARK: - Properties
    /// The source service
    private let sourceService = SourceService()
    
    /// Current sources
    private(set) var sources = [Source]()
    
    // MARK: - Closures
    var isLoading: ((Bool) -> Void)?
    var reloadData: (() -> Void)?
    
    // MARK: - Functions
    
    
    // MARK: - Private helper
//    private func loadSource() -> Set<Sources> {
//        
//    }
}
