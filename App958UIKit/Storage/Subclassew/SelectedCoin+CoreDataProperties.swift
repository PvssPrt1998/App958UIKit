

import Foundation
import CoreData


extension SelectedCoin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SelectedCoin> {
        return NSFetchRequest<SelectedCoin>(entityName: "SelectedCoin")
    }

    @NSManaged public var selected: Int32

}

extension SelectedCoin : Identifiable {

}
