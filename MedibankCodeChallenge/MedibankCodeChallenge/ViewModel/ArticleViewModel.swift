//  Copyright © 2020 Michael.H. All rights reserved.

import UIKit
import RxSwift

class ArticleViewModel: BaseViewModel {
    // MARK: - Properties
    /// The line list
    var articleList = [ArticleItem]()
    
    // Image cache list
    private var imageCache = NSCache<NSNumber, UIImage>()
    
    // Loading operation queue
    private let loadingQueue = OperationQueue()
    
    // Loading operation
    private var loadingOperations: [IndexPath: ImageLoadingOperation] = [:]
    
    /// The dispose bag
    let disposeBag = DisposeBag()
    
    // MARK: - Closures
    var isLoading: ((Bool) -> Void)?
    var fetchError: ((String) -> Void)?
    var reloadData: (() -> Void)?
    var openlink: ((ArticleItem) -> Void)?
    
    // MARK: - Functions
    func loadData() {}
    
    func imageForCell(_ indexpath: IndexPath, completion: @escaping (UIImage) -> Void) {
        // Image exist in cache
        if let image = imageCache.object(forKey: NSNumber(integerLiteral: indexpath.row)) {
            completion(image)
            return
        }
        
        // Completion handler
        let operationCompletion: (UIImage) -> () = { [weak self] image in
            guard let self = self else { return }
            completion(image)
            self.updateImageCache(image, indexpath: indexpath)
            return
        }
        
        // Check for existing operation
        if let operation = loadingOperations[indexpath] {
            if let image = operation.image {
                // Image loaded
                completion(image)
                updateImageCache(image, indexpath: indexpath)
            }
            else {
                // Image not loaded
                operation.completion = operationCompletion
            }
        }
        else {
            if let urlString = articleList[indexpath.row].thumbnailUrl {
                // Create new operation
                let newOp = ImageLoadingOperation(urlString)
                newOp.completion = operationCompletion
                loadingQueue.addOperation(newOp)
                loadingOperations[indexpath] = newOp
            }
        }
    }
    
    func openItem(_ indexpath: IndexPath) {
        let item = articleList[indexpath.row]
        openlink?(item)
    }
    
    func prefetchImage(_ indexpaths: [IndexPath]) {
        // Search for existing operation
        for indexpath in indexpaths {
            // Found existing operation, skip
            if let _ = loadingOperations[indexpath] {
                continue
            }
                        
            // Create new opetation for cell
            if let urlString = articleList[indexpath.row].thumbnailUrl {
                let newOp = ImageLoadingOperation(urlString)
                loadingQueue.addOperation(newOp)
                loadingOperations[indexpath] = newOp
            }
        }
    }
    
    func cancelprefetchImage(_ indexpaths: [IndexPath]) {
        // Search for existing operation
        for indexpath in indexpaths {
            // Cancel existing operation
            if let operation = loadingOperations[indexpath] {
                operation.cancel()
                loadingOperations.removeValue(forKey: indexpath)
            }
        }
    }
    
    func handleError(_ message: String) {
        isLoading?(false)
        fetchError?(message)
    }
    
    func finishLoading() {
        self.isLoading?(false)
        self.reloadData?()
    }
    
    func updateImageCache(_ image: UIImage, indexpath: IndexPath) {
        imageCache.setObject(image, forKey: NSNumber(integerLiteral: indexpath.row))
        loadingOperations.removeValue(forKey: indexpath)
    }
}
