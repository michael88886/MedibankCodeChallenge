//  Copyright © 2020 Michael.H. All rights reserved.

import UIKit
import RxSwift

class ImageLoadingOperation: Operation {
    // MARK: - Properties
    /// Image URL reference
    private let imgURL: URL!
    
    /// Image reference
    var image: UIImage?
    
    /// Operation complition
    var completion: ((UIImage) -> Void)?
    
    /// The dispose bag
    let disposebag = DisposeBag()
    
    // MARK: - Lifecycle
    init(_ urlString: String) {
        self.imgURL = URL(string: urlString)!
    }
    
    // MARK: Overrides
    override func main() {
        // Check Cancel
        if isCancelled { return }
        
        NetworkClient().downloadImage(self.imgURL)
            .subscribeOn(MainScheduler.instance)
            .subscribe(
                onSuccess: { [weak self] image in
                    self?.image = image
                    if let cancel = self?.isCancelled, cancel { return }
                    if let complete = self?.completion {
                        complete(image)
                    }
                },
                onError: { [weak self] _ in
                    if let complete = self?.completion {
                        complete(UIImage())
                    }
                })
            .disposed(by: disposebag)
    }
}
