import Foundation


protocol LessonStorageProtocol {
    
    func getLessonByDay(_ day: Days) -> [Lesson]
    
    func getLessonById(id: UUID) -> Lesson?
    
    func addLesson(name: String, startTime: String, endTime: String, day: String, teacher: Teacher?, classroom: Classroom?, type: TypeLesson?, color: String)
    
    func updateLesson(id: UUID, name: String, startTime: String, endTime: String, day: String, teacher: Teacher?, classroom: Classroom?, type: TypeLesson?, color: String)
    
    func deleteLesson(id: UUID)
    
}
