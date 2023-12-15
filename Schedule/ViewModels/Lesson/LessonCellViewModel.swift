import Foundation


final class LessonCellViewModel{
    
    let id: UUID
    let name: String
    let startTime: String
    let endTime: String
    let color: String
    let description: String
    
    
    init(_ lesson: Lesson) {
        self.id = lesson.id
        self.name = lesson.name
        self.startTime = lesson.startTime
        self.endTime = lesson.endTime
        var classroomDescription: String = ""
        var teacherDescription: String = ""
        var typeDescription: String = ""
        if let classroom = lesson.classroom {
            classroomDescription = "Аудитория \(classroom.number) этаж \(classroom.floor)"
        }
        if let teacher = lesson.teacher {
            teacherDescription = "\(teacher.name)\n"
        }
        if let type = lesson.type {
            typeDescription = "\(type.type)\n"
        }
        
        self.description = typeDescription + teacherDescription + classroomDescription
        self.color = lesson.color
    }
    
}
