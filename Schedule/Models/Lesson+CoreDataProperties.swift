import Foundation
import CoreData


extension Lesson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lesson> {
        return NSFetchRequest<Lesson>(entityName: "Lesson")
    }

    @NSManaged public var name: String
    @NSManaged public var startTime: String
    @NSManaged public var endTime: String
    @NSManaged public var id: UUID
    @NSManaged public var day: String
    @NSManaged public var color: String
    @NSManaged public var teacher: Teacher?
    @NSManaged public var classroom: Classroom?
    @NSManaged public var type: TypeLesson?

}

extension Lesson : Identifiable {

}
