import Foundation


final class TypeLessonCellViewModel {
    
    let id: UUID
    let description: String
    
    init(type: TypeLesson){
        self.id = type.id
        self.description = type.type
    }
    
}
