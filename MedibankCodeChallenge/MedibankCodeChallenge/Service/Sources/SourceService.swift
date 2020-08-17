//  Copyright © 2020 Michael.H. All rights reserved.

import Foundation
import RxSwift

final class SourceService {
    
    // MARK: - Properties
    /// The network client
    private var networkClient = NetworkClient()
    
    // MARK: - Functions
    func loadSource() -> Single<SourceModel> {
        return (networkClient.networkRequest(.source) as Single <SourceResponse>)
            .observeOn(MainScheduler.instance)
            .map(SourceMapper().mapToModel)
            .catchError { error in
                Single.error(error)
        }
    }
    
    func saveToCoreData(items: [SourceItem]) {
        let defaults = UserDefaults.standard
        var sourceIds = [String]()
        for item in items {
            sourceIds.append(item.id)
        }
        defaults.set(sourceIds, forKey: "Sources")
        defaults.synchronize()
    }
}
