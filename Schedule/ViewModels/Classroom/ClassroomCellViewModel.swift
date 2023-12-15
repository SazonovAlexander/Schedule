import Foundation


final class ClassroomCellViewModel {
    
    let id: UUID
    let description: String
    
    init(classroom: Classroom) {
        self.id = classroom.id
        self.description = "Номер \(classroom.number), этаж \(classroom.floor)"
    }
    
}
