import Foundation


final class ClassroomTableViewModel: ClassroomTableViewModelProtocol {

    private let storageManager: ClassroomStorageProtocol
    
    var cellDataClassrooms: Observable<[ClassroomCellViewModel]>
    
    init(storageManager: ClassroomStorageProtocol, cellDataClassrooms: Observable<[ClassroomCellViewModel]> = Observable(value: [])) {
        self.storageManager = storageManager
        self.cellDataClassrooms = cellDataClassrooms
        setupClassrooms()
    }
    
    
    func setupClassrooms() {
        cellDataClassrooms.value = storageManager.getClassrooms().map({
            ClassroomCellViewModel(classroom: $0)
        })
    }
    
    func delete(id: UUID) {
        storageManager.deleteClassroom(id: id)
    }
    
}
