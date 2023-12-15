import Foundation


protocol TeacherTableViewModelProtocol {
    
    var cellDataTeachers: Observable<[TeacherCellViewModel]> { get }
    
    func setupTeachers()
    
    func delete(id: UUID)
        
}
