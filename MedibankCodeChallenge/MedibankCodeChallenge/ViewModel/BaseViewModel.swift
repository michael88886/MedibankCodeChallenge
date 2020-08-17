//  Copyright © 2020 Michael.H. All rights reserved.

import Foundation

protocol BaseViewModel {
    var isLoading: ((Bool) -> Void)? { get set }
    var fetchError: ((String) -> Void)? {get set}
    var reloadData: (() -> Void)? { get set }
}
