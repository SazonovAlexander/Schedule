import Foundation


protocol LessonViewModelProtocol {
    var id: UUID? { get set }
    
    var colors: [String: String] { get }
    var hours: [String] { get }
    var minuts: [String] { get }
    var days: [Days] { get }
    
    var teachers: [TeacherCellViewModel] { get }
    var classrooms: [ClassroomCellViewModel] { get }
    var types: [TypeLessonCellViewModel] { get }

    var startTimeHour: Observable<String> { get set }
    var startTimeMinut: Observable<String> { get set }
    var endTimeHour: Observable<String> { get set }
    var endTimeMinut: Observable<String> { get set }
    
    var name: String? { get set }
    var selectedDay: Observable<Days> { get }
    var selectedColor: Observable<String> { get }
    var selectedTeacherId: Observable<UUID> { get }
    var selectedClassroomId: Observable<UUID> { get }
    var selectedTypeId: Observable<UUID> { get }
    
    func save()
}
