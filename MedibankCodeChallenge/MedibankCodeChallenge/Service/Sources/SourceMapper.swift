//  Copyright © 2020 Michael.H. All rights reserved.

import Foundation

struct SourceMapper {
    
    func mapToModel(_ response: SourceResponse) -> SourceModel {
        guard response.status == "ok" else {
            return SourceModel(sources: [],
                               errorMessage: response.message)
        }
        
        guard let data = response.sources,
            data.count > 0 else {
                return SourceModel(sources: [],
                                   errorMessage: nil)
        }
        
        var sources = [SourceItem]()
        for item in data {
            let source = SourceItem(id: item.id,
                                    name: item.name,
                                    link: item.url,
                                    countryFlag: Utility.toFlag(item.country),
                                    selected: false)
            sources.append(source)
        }
        return SourceModel(sources: sources,
                           errorMessage: nil)
    }
}
