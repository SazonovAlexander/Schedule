import Foundation


final class ClassroomViewModel: ClassroomViewModelProtocol {
    
    var id: UUID?
    
    var floor: Int16?
    
    var number: Int16?
    
    private let storageManager: ClassroomStorageProtocol
    
    init(id: UUID? = nil, storageManager: ClassroomStorageProtocol = CoreDataManager.shared) {
        self.id = id
        self.storageManager = storageManager
        if let id, let classroom = storageManager.getClassroomById(id: id) {
            self.floor = classroom.floor
            self.number = classroom.number
        }
    }
    
    func save() {
        if let floor = self.floor, let number = self.number {
            if let id = self.id {
                storageManager.updateClassroom(id: id, floor: floor, number: number)
            }
            else {
                storageManager.addClassroom(floor: floor, number: number)
            }
        }
    }

}
