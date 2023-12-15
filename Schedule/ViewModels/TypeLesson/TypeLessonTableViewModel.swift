import Foundation


final class TypeLessonTableViewModel: TypeLessonTableViewModelProtocol {
    
    private let storageManager: TypeLessonStorageProtocol
    
    var cellDataType: Observable<[TypeLessonCellViewModel]>
    
    init(storageManager: TypeLessonStorageProtocol, cellDataType: Observable<[TypeLessonCellViewModel]> = Observable(value: [])) {
        self.storageManager = storageManager
        self.cellDataType = cellDataType
        setupTypeLesson()
    }
    
    
    func setupTypeLesson() {
        cellDataType.value = storageManager.getTypes().map({
            TypeLessonCellViewModel(type: $0)
        })
    }
    
    func delete(id: UUID) {
        storageManager.deleteTypeLesson(id: id)
    }
    
}
