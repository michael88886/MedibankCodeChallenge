//  Copyright © 2020 Michael.H. All rights reserved.

import Foundation
import CoreData


extension Source {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Source> {
        return NSFetchRequest<Source>(entityName: "Source")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var url: String?

}
