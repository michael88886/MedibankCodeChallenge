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
}
