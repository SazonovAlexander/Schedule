import Foundation


protocol TypeLessonStorageProtocol {
    
    func getTypes() -> [TypeLesson]
    
    func getTypeById(id: UUID) -> TypeLesson?
    
    func addTypeLesson(type: String)
    
    func updateTypeLesson(id: UUID, type: String)
    
    func deleteTypeLesson(id: UUID)
    
}
