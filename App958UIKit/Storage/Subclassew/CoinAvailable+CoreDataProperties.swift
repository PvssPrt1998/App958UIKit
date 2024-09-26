

import Foundation
import CoreData


extension CoinAvailable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoinAvailable> {
        return NSFetchRequest<CoinAvailable>(entityName: "CoinAvailable")
    }

    @NSManaged public var id: Int32
    @NSManaged public var available: Bool

}

extension CoinAvailable : Identifiable {

}
