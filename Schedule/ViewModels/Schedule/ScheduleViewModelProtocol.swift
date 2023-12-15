import Foundation


protocol ScheduleViewModelProtocol {
    
    var currentDay: Days? { get set }
    
    var cellDataCurrentDay: Observable<[LessonCellViewModel]> { get }
    
    func delete(id: UUID)
}
