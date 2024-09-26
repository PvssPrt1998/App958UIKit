

import Foundation
import CoreData


extension SelectedBall {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SelectedBall> {
        return NSFetchRequest<SelectedBall>(entityName: "SelectedBall")
    }

    @NSManaged public var selected: Int32

}

extension SelectedBall : Identifiable {

}
