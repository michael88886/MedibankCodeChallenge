//  Copyright © 2020 Michael.H. All rights reserved.

import UIKit
import RxSwift

class HeadlineViewModel: ArticleViewModel {
    /// The headline service
    private let headlineService = HeadlineService()
    
    // MARK: - Overrides
    override func loadData() {
        isLoading?(true)
        
        headlineService.loadHeadlines()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess: { [weak self] headlineModel in
                    if let errorMessage = headlineModel.errorMessage {
                        self?.handleError(errorMessage)
                        return
                    }
                    
                    self?.articleList = headlineModel.articles
                    self?.finishLoading()
                },
                onError: { [weak self] error in
                    if let serviceError = error as? AppError {
                        let message = serviceError.message()
                        self?.handleError(message)
                    }
            })
            .disposed(by: disposeBag)
    }
}
