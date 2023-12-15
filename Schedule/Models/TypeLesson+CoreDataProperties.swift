import Foundation
import CoreData


extension TypeLesson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TypeLesson> {
        return NSFetchRequest<TypeLesson>(entityName: "TypeLesson")
    }

    @NSManaged public var type: String
    @NSManaged public var id: UUID
    @NSManaged public var lesson: Lesson?

}

extension TypeLesson : Identifiable {

}
