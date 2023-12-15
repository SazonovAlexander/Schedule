import Foundation


final class TeacherTableViewModel: TeacherTableViewModelProtocol {
    
    private let storageManager: TeacherStorageProtocol
    
    var cellDataTeachers: Observable<[TeacherCellViewModel]>
    
    init(storageManager: TeacherStorageProtocol, cellDataTeachers: Observable<[TeacherCellViewModel]> = Observable(value: [])) {
        self.storageManager = storageManager
        self.cellDataTeachers = cellDataTeachers
        setupTeachers()
    }
    
    
    func setupTeachers() {
        cellDataTeachers.value = storageManager.getTeachers().map({
            TeacherCellViewModel(teacher: $0)
        })
    }
    
    func delete(id: UUID) {
        storageManager.deleteTeacher(id: id)
    }
    
}
