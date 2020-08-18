//  Copyright © 2020 Michael.H. All rights reserved.

import Foundation

class SavedViewModel: BaseViewModel {
    
    // MARK: - Properties
    /// The saved service
    private let savedService = SavedService()
    
    /// The saved article list
    private(set) var savedArticle = [ArticleItem]()
    
    // MARK: - Closures
    var isLoading: ((Bool) -> Void)?
    var fetchError: ((String) -> Void)?
    var reloadData: (() -> Void)?
    var openlink: ((ArticleItem) -> Void)?
    
    // MARK: - Functions
    func loadSavedArticle() {
        isLoading?(true)
        savedArticle = savedService.fetchSavedArticles()
        finishLoading()
    }
    
    func openItem(_ indexpath: IndexPath) {
        let item = savedArticle[indexpath.row]
        openlink?(item)
    }
    
    func deleteItem(_ indexpath: IndexPath) {
        savedArticle.remove(at: indexpath.row)
        savedService.updateSavedList(savedArticle)
    }
    
    // MARK: - Private helper
    private func finishLoading() {
        self.isLoading?(false)
        self.reloadData?()
    }
}
