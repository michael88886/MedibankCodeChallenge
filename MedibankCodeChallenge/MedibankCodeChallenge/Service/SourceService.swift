//  Copyright © 2020 Michael.H. All rights reserved.

import Foundation
import CoreData

final class SourceService {
    
    // MARK: - Properties
    /// Core data fetch result
    private var fetchResult: NSPersistentStoreAsynchronousResult? = nil
    
    func fetchSources(completion: @escaping ([Source]?, Error?) -> Void) {
        // Data context
        let context = Utility.dataContext()
        
        // Fetch request
        let fetchRequest = NSFetchRequest<Source>(entityName: "Source")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        // Asynchronous fetch
        let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (asychronousFetchResult) in
            guard let result = asychronousFetchResult.finalResult else { return }
            // Call back main queue
            DispatchQueue.main.async {
                completion(result, nil)
            }
        }
        
        // Execute feteching
        do {
            fetchResult = try context.execute(asyncFetchRequest) as? NSPersistentStoreAsynchronousResult
        } catch {
            completion(nil, AppError.failedFetchSource)
        }
    }
    
    func cancelFetch() {
        fetchResult?.cancel()
    }
}
