//  Copyright © 2020 Michael.H. All rights reserved.

import Foundation

final class SavedService {
    
    // MARK: - Properties
    
    // MARK: - Closure
    var articleSaved: (() -> Void)?
    
    // MARK: - Functions
    func fetchSavedArticles() -> [ArticleItem] {
        var articleList = [ArticleItem]()
        let storedData = UserDefaults.standard.array(forKey: "SavedArticles") as? [Data]
        let dataList = storedData ?? [Data]()
        if dataList.count > 0 {
            for data in dataList {
                if let article = try? JSONDecoder().decode(ArticleItem.self, from: data) {
                    articleList.append(article)
                }
            }
        }
        return articleList
    }
    
    func saveArticle(_ article: ArticleItem) {
        let defaults = UserDefaults.standard
        
        var currentSaved = fetchSavedArticles()
        currentSaved.append(article)
        
        let encodeData = encodeList(currentSaved)
        defaults.set(encodeData, forKey: "SavedArticles")
        defaults.synchronize()
        articleSaved?()
    }
    
    func updateSavedList(_ list: [ArticleItem]) {
        let defaults = UserDefaults.standard
        
        let encodeData = encodeList(list)
        defaults.set(encodeData, forKey: "SavedArticles")
        defaults.synchronize()
    }
    
    // MARK: - Private helper
    private func encodeList(_ list: [ArticleItem]) -> [Data] {
        var dataList = [Data]()
        for item in list {
            if let encode = try? JSONEncoder().encode(item) {
                dataList.append(encode)
            }
        }
        return dataList
    }
}
