import Foundation


protocol ClassroomViewModelProtocol {
    
    var id: UUID? { get }
    var floor: Int16? { get set }
    var number: Int16? { get set }
    
    func save()
    
}
