import Foundation


final class TypeLessonViewModel: TypeLessonViewModelProtocol {
    
    let id: UUID?
    var type: String?
    
    private let storageManager: TypeLessonStorageProtocol
    
    init(id: UUID? = nil, storageManager: TypeLessonStorageProtocol = CoreDataManager.shared) {
        self.id = id
        self.storageManager = storageManager
        if let id, let type = storageManager.getTypeById(id: id) {
            self.type = type.type
        }
    }
    
    func save() {
        if let type = self.type {
            if let id = self.id {
                storageManager.updateTypeLesson(id: id, type: type)
            }
            else {
                storageManager.addTypeLesson(type: type)
            }
        }
    }
    
}
