import Foundation


protocol TypeLessonTableViewModelProtocol {
    
    var cellDataType: Observable<[TypeLessonCellViewModel]> { get }
    
    func setupTypeLesson()
    
    func delete(id: UUID)
        
}
