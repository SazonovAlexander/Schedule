import Foundation
import CoreData


extension Classroom {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Classroom> {
        return NSFetchRequest<Classroom>(entityName: "Classroom")
    }

    @NSManaged public var floor: Int16
    @NSManaged public var number: Int16
    @NSManaged public var id: UUID
    @NSManaged public var lesson: Lesson?

}

extension Classroom : Identifiable {

}
