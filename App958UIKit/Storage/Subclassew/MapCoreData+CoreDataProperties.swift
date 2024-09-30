import Foundation
import CoreData


extension MapCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MapCoreData> {
        return NSFetchRequest<MapCoreData>(entityName: "MapCoreData")
    }

    @NSManaged public var id: Int32
    @NSManaged public var available: Bool

}

extension MapCoreData : Identifiable {

}
