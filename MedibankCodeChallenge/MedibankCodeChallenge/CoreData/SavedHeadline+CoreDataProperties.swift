//  Copyright © 2020 Michael.H. All rights reserved.

import Foundation
import CoreData


extension SavedHeadline {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedHeadline> {
        return NSFetchRequest<SavedHeadline>(entityName: "SavedHeadline")
    }

    @NSManaged public var author: String?
    @NSManaged public var desc: String?
    @NSManaged public var publishDate: Date?
    @NSManaged public var title: String?

}
