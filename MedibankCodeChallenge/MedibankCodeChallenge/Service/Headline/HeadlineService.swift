//  Copyright © 2020 Michael.H. All rights reserved.

import Foundation
import RxSwift

final class HeadlineService {
    
    // MARK: - Properties
    /// The network client
    private var networkClient = NetworkClient()
    
    // MARK: - Functions
    func loadHeadlines() -> Single<HeadlineModel> {
        var querries = [URLQueryItem]()
        let selectedSource = Utility.fetchSelectedSources()
        let sources = selectedSource.joined(separator: ",")
        
        if !sources.isEmpty {
            querries.append(URLQueryItem(
                name: "sources",
                value: sources))
        }
        
        return (networkClient.networkRequest(.headline, querries: querries) as Single<HeadlineResponse>)
            .observeOn(MainScheduler.instance)
            .map(HeadlineMapper().mapToModel)
            .catchError { error in
                Single.error(error)
        }
    }
}
