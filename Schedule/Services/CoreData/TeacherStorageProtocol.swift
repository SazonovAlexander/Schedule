import Foundation


protocol TeacherStorageProtocol {
    
    func getTeachers() -> [Teacher]
    
    func getTeacherById(id: UUID) -> Teacher?
    
    func addTeacher(name: String, phoneNumber: String?)
    
    func updateTeacher(id: UUID, name: String, phoneNumber: String?)
    
    func deleteTeacher(id: UUID)
    
}
