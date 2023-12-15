import Foundation


protocol ClassroomTableViewModelProtocol {
    
    var cellDataClassrooms: Observable<[ClassroomCellViewModel]> { get }
    
    func setupClassrooms()
    
    func delete(id: UUID)
    
}
