import Foundation


protocol TeacherViewModelProtocol {
    
    var id: UUID? { get }
    var name: String? { get set }
    var phone: String? { get set }
    
    func save()
    
}
