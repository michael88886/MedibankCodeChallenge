//  Copyright © 2020 Michael.H. All rights reserved.

import UIKit

struct HeadlineMapper {
    func mapToModel(_ response: HeadlineResponse) -> HeadlineModel {
        guard response.status == "ok" else {
            return HeadlineModel(articles: [],
                                 errorMessage: response.message)
        }
        
        guard let data = response.articles,
            data.count > 0 else {
                return HeadlineModel(articles: [],
                                     errorMessage: nil)
        }

        var articles = [ArticleItem]()
        for item in data {
            let article = ArticleItem(title: item.title,
                                      description: item.description,
                                      thumbnailUrl: item.urlToImage,
                                      url: item.url,
                                      author: item.author,
                                      sourceId: item.source.id,
                                      sourceName: item.source.name)
            articles.append(article)
        }
        return HeadlineModel(articles: articles,
                             errorMessage: nil)
    }
}
