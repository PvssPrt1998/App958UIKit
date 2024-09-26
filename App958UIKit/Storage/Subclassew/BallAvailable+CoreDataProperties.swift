
import Foundation
import CoreData


extension BallAvailable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BallAvailable> {
        return NSFetchRequest<BallAvailable>(entityName: "BallAvailable")
    }

    @NSManaged public var id: Int32
    @NSManaged public var available: Bool

}

extension BallAvailable : Identifiable {

}
