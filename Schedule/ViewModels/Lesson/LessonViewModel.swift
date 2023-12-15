import Foundation


final class LessonViewModel: LessonViewModelProtocol {
 
    var id: UUID?
    
    var name: String?
    
    let colors = ["Синий": "#0000FF",
                  "Зеленый": "#00FF00",
                  "Красный": "#FF0000",
                  "Оранжевый": "#FF8000",
                  "Фиолетовый": "#800080",
                  "Желтый": "#FFFF00"]
    
    let days: [Days] = Days.allCases
    
    let hours: [String] = ["08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
    
    let minuts: [String] = ["00", "05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55"]
    
    var teachers: [TeacherCellViewModel]
    
    var classrooms: [ClassroomCellViewModel]
    
    var types: [TypeLessonCellViewModel]
    
    var startTimeHour: Observable<String>
    
    var startTimeMinut: Observable<String>
    
    var endTimeHour: Observable<String>
    
    var endTimeMinut: Observable<String>
    
    var selectedColor: Observable<String>
    
    var selectedTeacherId: Observable<UUID>
    
    var selectedClassroomId: Observable<UUID>
    
    var selectedTypeId: Observable<UUID>
    
    var selectedDay: Observable<Days>
    
    private let storageManager: LessonStorageProtocol & TeacherStorageProtocol & ClassroomStorageProtocol & TypeLessonStorageProtocol
    
    init(idLesson: UUID?, storageManager: LessonStorageProtocol & TeacherStorageProtocol & ClassroomStorageProtocol & TypeLessonStorageProtocol) {
        self.id = idLesson
        self.storageManager = storageManager
        self.teachers = storageManager.getTeachers().map({TeacherCellViewModel(teacher: $0)})
        self.classrooms = storageManager.getClassrooms().map({ClassroomCellViewModel(classroom: $0)})
        self.types = storageManager.getTypes().map({TypeLessonCellViewModel(type: $0)})
        if let id, let lesson = storageManager.getLessonById(id: id) {
            let startHour = lesson.startTime.split(separator: ":").first
            let startMinut = lesson.startTime.split(separator: ":").last
            let endHour = lesson.endTime.split(separator: ":").first
            let endMinut = lesson.endTime.split(separator: ":").last
            self.startTimeHour = Observable(value: String(startHour ?? ""))
            self.startTimeMinut = Observable(value: String(startMinut ?? ""))
            self.endTimeHour = Observable(value: String(endHour ?? ""))
            self.endTimeMinut = Observable(value: String(endMinut ?? ""))
            self.selectedColor = Observable(value: lesson.color)
            self.selectedTeacherId = Observable(value: lesson.teacher?.id ?? nil)
            self.selectedClassroomId = Observable(value: lesson.classroom?.id ?? nil)
            self.selectedTypeId = Observable(value: lesson.type?.id ?? nil)
            self.selectedDay = Observable(value: Days(rawValue: lesson.day))
            self.name = lesson.name
        }
        else {
            self.startTimeHour = Observable(value: "08")
            self.startTimeMinut = Observable(value: "00")
            self.endTimeHour = Observable(value: "08")
            self.endTimeMinut = Observable(value: "00")
            self.selectedColor = Observable(value: "#FF0000")
            self.selectedTeacherId = Observable(value: nil)
            self.selectedClassroomId = Observable(value: nil)
            self.selectedTypeId = Observable(value: nil)
            self.selectedDay = Observable(value: .monday)
        }
    }
    
    func save() {
        guard let startTimeHour = startTimeHour.value,
              let startTimeMinut = startTimeMinut.value,
              let endTimeHour = endTimeHour.value,
              let endTimeMinut = endTimeMinut.value,
              let day = selectedDay.value,
              let color = selectedColor.value,
              let name = name
        else { return }
        var teacher: Teacher?
        var classroom: Classroom?
        var type: TypeLesson?
        if let teacherId = selectedTeacherId.value {
            teacher = storageManager.getTeacherById(id: teacherId)
        }
        if let classroomId = selectedClassroomId.value {
            classroom = storageManager.getClassroomById(id: classroomId)
        }
        if let typeId = selectedTypeId.value {
            type = storageManager.getTypeById(id: typeId)
        }
        if let id = self.id {
            storageManager.updateLesson(
                id: id,
                name: name,
                startTime: "\(startTimeHour):\(startTimeMinut)",
                endTime: "\(endTimeHour):\(endTimeMinut)",
                day: day.rawValue,
                teacher: teacher,
                classroom: classroom,
                type: type,
                color: color)
        }
        else {
            storageManager.addLesson(
                name: name,
                startTime: "\(startTimeHour):\(startTimeMinut)",
                endTime: "\(endTimeHour):\(endTimeMinut)",
                day: day.rawValue,
                teacher: teacher,
                classroom: classroom,
                type: type,
                color: color)
        }
    }
    
}
