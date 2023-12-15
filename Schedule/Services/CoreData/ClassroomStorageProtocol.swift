import Foundation


protocol ClassroomStorageProtocol {
    
    func getClassrooms() -> [Classroom]
    
    func getClassroomById(id: UUID) -> Classroom?
    
    func addClassroom(floor: Int16, number: Int16)
    
    func updateClassroom(id: UUID, floor: Int16, number: Int16)
    
    func deleteClassroom(id: UUID)
    
}
