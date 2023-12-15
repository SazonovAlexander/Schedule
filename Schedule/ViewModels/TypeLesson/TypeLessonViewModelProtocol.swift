import Foundation


protocol TypeLessonViewModelProtocol {
    
    var id: UUID? { get }
    var type: String? { get set }
    
    func save()
    
}
