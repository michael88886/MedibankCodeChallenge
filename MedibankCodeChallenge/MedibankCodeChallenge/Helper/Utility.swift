//  Copyright © 2020 Michael.H. All rights reserved.

import UIKit
import CoreData

final class Utility {
    //// Will get core data context
    static func dataContext() -> NSManagedObjectContext {
        // Get app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // Data context
        return appDelegate.persistentContainer.viewContext
    }
    
    /// Will convert two letter into enmoji icon
    /// Credit:  https://stackoverflow.com/a/60413173
    static func toFlag(_ countryCode: String) -> String {
        let base: UInt32 = 127397
        return countryCode.uppercased()
            .unicodeScalars
            .map({ base + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
    
    /// Generic error alert
    static func errorAlert(with title: String, message: String) -> UIAlertController {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alertVC
    }
}
