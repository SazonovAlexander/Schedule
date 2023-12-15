import Foundation


final class ScheduleViewModel: ScheduleViewModelProtocol {
    
    private let storageManager: LessonStorageProtocol
    
    var currentDay: Days? {
        didSet {
            if let currentDay {
                let lessons = storageManager.getLessonByDay(currentDay).map({LessonCellViewModel($0)}).sorted(by: {$0.startTime < $1.startTime})
                cellDataCurrentDay.value = lessons
            }
        }
    }
    
    var cellDataCurrentDay: Observable<[LessonCellViewModel]>
    
    init(storageManager: LessonStorageProtocol,
         cellDataCurrentDay: Observable<[LessonCellViewModel]> = Observable<[LessonCellViewModel]>(value: [])) {
        self.storageManager = storageManager
        self.cellDataCurrentDay = cellDataCurrentDay
    }
    
    func delete(id: UUID) {
        storageManager.deleteLesson(id: id)
    }
    
}
