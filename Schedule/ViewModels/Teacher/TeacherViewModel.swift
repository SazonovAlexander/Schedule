import Foundation


final class TeacherViewModel: TeacherViewModelProtocol {
    
    let id: UUID?
    var name: String?
    var phone: String?
    
    private let storageManager: TeacherStorageProtocol
    
    init(id: UUID? = nil, storageManager: TeacherStorageProtocol = CoreDataManager.shared) {
        self.id = id
        self.storageManager = storageManager
        if let id, let teacher = storageManager.getTeacherById(id: id) {
            self.name = teacher.name
            self.phone = teacher.phoneNumber
        }
    }
    
    func save() {
        if let name = self.name {
            if let id = self.id {
                storageManager.updateTeacher(id: id, name: name, phoneNumber: self.phone)
            }
            else {
                storageManager.addTeacher(name: name, phoneNumber: self.phone)
            }
        }
    }
    
}
