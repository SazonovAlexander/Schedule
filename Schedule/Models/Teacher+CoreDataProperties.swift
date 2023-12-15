import Foundation
import CoreData


extension Teacher {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Teacher> {
        return NSFetchRequest<Teacher>(entityName: "Teacher")
    }

    @NSManaged public var name: String
    @NSManaged public var phoneNumber: String?
    @NSManaged public var id: UUID
    @NSManaged public var lesson: Lesson?

}

extension Teacher : Identifiable {

}
