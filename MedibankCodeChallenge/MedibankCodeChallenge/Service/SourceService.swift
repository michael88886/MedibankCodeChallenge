//  Copyright © 2020 Michael.H. All rights reserved.

import Foundation
import CoreData
import RxSwift

final class SourceService {
    
    // MARK: - Properties
    /// Core data fetch result
    private var fetchResult: NSPersistentStoreAsynchronousResult? = nil
    
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
    
    func fetchSelectedSources() -> Single<[String]> {
        return Single<[String]>.create { single in
            let item = UserDefaults.standard.array(forKey: "Sources") as? [String]
            let sources = item ?? []
            single(.success(sources))
            return Disposables.create()
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
