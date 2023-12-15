import Foundation


final class TeacherCellViewModel {
    
    let id: UUID
    let description: String
    
    init(teacher: Teacher) {
        self.id = teacher.id
        self.description = "\(teacher.name)\n\(teacher.phoneNumber ?? "")"
    }
}
