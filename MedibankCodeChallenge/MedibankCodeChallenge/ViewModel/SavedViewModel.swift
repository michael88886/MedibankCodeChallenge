//  Copyright © 2020 Michael.H. All rights reserved.

import Foundation

class SavedViewModel: ArticleViewModel {
    
    // MARK: - Properties
    /// The saved service
    private let savedService = SavedService()
    
    // MARK: - Functions
    override func loadData() {
        isLoading?(true)
        articleList = savedService.fetchSavedArticles()
        finishLoading()
    }
    
    func deleteItem(_ indexpath: IndexPath) {
        articleList.remove(at: indexpath.row)
        savedService.updateSavedList(articleList)
    }
}
