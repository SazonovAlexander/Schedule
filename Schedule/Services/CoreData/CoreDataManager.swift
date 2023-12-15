import Foundation
import CoreData


final class CoreDataManager {
    
   static var shared = CoreDataManager()
    
   init(){}
    
    
   private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Schedule")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()



    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private lazy var viewContext = persistentContainer.viewContext
    
    
}

        
//MARK: - LessonStorageProtocol
extension CoreDataManager: LessonStorageProtocol {
    
    func getLessonByDay(_ day: Days) -> [Lesson] {
        var lessons = [Lesson]()
        
        let fetchRequest: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        let predicate = NSPredicate(format: "day=%@", day.rawValue)
        fetchRequest.predicate = predicate
        
        do {
            lessons = try viewContext.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
        
        return lessons
    }
    
    func getLessonById(id: UUID) -> Lesson? {
        var lesson: Lesson?
        let fetchRequest: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", id.uuidString)
        fetchRequest.predicate = predicate
        
        do {
            lesson = try viewContext.fetch(fetchRequest).first ?? nil
        } catch let error {
            print(error.localizedDescription)
        }
        
        return lesson
    }
    
    
    func addLesson(name: String, startTime: String, endTime: String, day: String, teacher: Teacher?, classroom: Classroom?, type: TypeLesson?, color: String) {
        
        let lesson = Lesson(context: viewContext)
        
        lesson.id = UUID()
        lesson.name = name
        lesson.startTime = startTime
        lesson.endTime = endTime
        lesson.teacher = teacher
        lesson.classroom = classroom
        lesson.type = type
        lesson.day = day
        lesson.color = color
        
        saveContext()
        
    }
    
    func updateLesson(id: UUID, name: String, startTime: String, endTime: String, day: String, teacher: Teacher?, classroom: Classroom?, type: TypeLesson?, color: String){
        
        let fetchRequest: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", id.uuidString)
        fetchRequest.predicate = predicate
        
        do {
            if let fetchedLesson = try viewContext.fetch(fetchRequest).first {
                fetchedLesson.name = name
                fetchedLesson.startTime = startTime
                fetchedLesson.endTime = endTime
                fetchedLesson.teacher = teacher
                fetchedLesson.classroom = classroom
                fetchedLesson.type = type
                fetchedLesson.day = day
                fetchedLesson.color = color
                
                saveContext()
            }
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func deleteLesson(id: UUID) {
        let fetchRequest: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", id.uuidString)
        fetchRequest.predicate = predicate
        
        do {
            if let fetchedLesson = try viewContext.fetch(fetchRequest).first {
                viewContext.delete(fetchedLesson)
                saveContext()
            }
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
}

//MARK: - TeacherStorageProtocol
extension CoreDataManager: TeacherStorageProtocol {
    func getTeacherById(id: UUID) -> Teacher? {
        var teacher: Teacher?
        let fetchRequest: NSFetchRequest<Teacher> = Teacher.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", id.uuidString)
        fetchRequest.predicate = predicate
        
        do {
            teacher = try viewContext.fetch(fetchRequest).first ?? nil
        } catch let error {
            print(error.localizedDescription)
        }
        
        return teacher
    }
    
    func getTeachers() -> [Teacher] {
        var teachers = [Teacher]()
        
        let fetchRequest: NSFetchRequest<Teacher> = Teacher.fetchRequest()

        do {
            teachers = try viewContext.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
        
        return teachers
    }
    
    func addTeacher(name: String, phoneNumber: String?) {
        let teacher = Teacher(context: viewContext)
        
        teacher.id = UUID()
        teacher.name = name
        teacher.phoneNumber = phoneNumber
      
        saveContext()
    }
    
    func updateTeacher(id: UUID, name: String, phoneNumber: String?) {
        let fetchRequest: NSFetchRequest<Teacher> = Teacher.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", id.uuidString)
        fetchRequest.predicate = predicate
        
        do {
            if let fetchedTeacher = try viewContext.fetch(fetchRequest).first {
                fetchedTeacher.name = name
                fetchedTeacher.phoneNumber = phoneNumber
                
                saveContext()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func deleteTeacher(id: UUID) {
        let fetchRequest: NSFetchRequest<Teacher> = Teacher.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", id.uuidString)
        fetchRequest.predicate = predicate
        
        do {
            if let fetchedTeacher = try viewContext.fetch(fetchRequest).first {
                viewContext.delete(fetchedTeacher)
                saveContext()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}


//MARK: - TypeLessonStorageProtocol
extension CoreDataManager: TypeLessonStorageProtocol {
    func getTypeById(id: UUID) -> TypeLesson? {
        var typeLesson: TypeLesson?
        let fetchRequest: NSFetchRequest<TypeLesson> = TypeLesson.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", id.uuidString)
        fetchRequest.predicate = predicate
        
        do {
            typeLesson = try viewContext.fetch(fetchRequest).first ?? nil
        } catch let error {
            print(error.localizedDescription)
        }
        
        return typeLesson
    }
    
    func getTypes() -> [TypeLesson] {
        var types = [TypeLesson]()
        
        let fetchRequest: NSFetchRequest<TypeLesson> = TypeLesson.fetchRequest()

        do {
            types = try viewContext.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
        
        return types
    }
    
    func addTypeLesson(type: String) {
        let typeLesson = TypeLesson(context: viewContext)
        
        typeLesson.id = UUID()
        typeLesson.type = type
      
        saveContext()
    }
    
    func updateTypeLesson(id: UUID, type: String) {
        let fetchRequest: NSFetchRequest<TypeLesson> = TypeLesson.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", id.uuidString)
        fetchRequest.predicate = predicate
        
        do {
            if let fetchedType = try viewContext.fetch(fetchRequest).first {
                fetchedType.type = type
                
                saveContext()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func deleteTypeLesson(id: UUID) {
        let fetchRequest: NSFetchRequest<TypeLesson> = TypeLesson.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", id.uuidString)
        fetchRequest.predicate = predicate
        
        do {
            if let fetchedType = try viewContext.fetch(fetchRequest).first {
                viewContext.delete(fetchedType)
                saveContext()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}


extension CoreDataManager: ClassroomStorageProtocol {
    func getClassroomById(id: UUID) -> Classroom? {
        var classroom: Classroom?
        let fetchRequest: NSFetchRequest<Classroom> = Classroom.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", id.uuidString)
        fetchRequest.predicate = predicate
        
        do {
            classroom = try viewContext.fetch(fetchRequest).first ?? nil
        } catch let error {
            print(error.localizedDescription)
        }
        
        return classroom
    }
    
    func getClassrooms() -> [Classroom] {
        var classrooms = [Classroom]()
        
        let fetchRequest: NSFetchRequest<Classroom> = Classroom.fetchRequest()

        do {
            classrooms = try viewContext.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
        
        return classrooms
    }
    
    func addClassroom(floor: Int16, number: Int16) {
        let classroom = Classroom(context: viewContext)
        
        classroom.id = UUID()
        classroom.floor = floor
        classroom.number = number
    
        saveContext()
    }
    
    func updateClassroom(id: UUID, floor: Int16, number: Int16) {
        let fetchRequest: NSFetchRequest<Classroom> = Classroom.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", id.uuidString)
        fetchRequest.predicate = predicate
        
        do {
            if let fetchedClassroom = try viewContext.fetch(fetchRequest).first {
                fetchedClassroom.floor = floor
                fetchedClassroom.number = number
                saveContext()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func deleteClassroom(id: UUID) {
        let fetchRequest: NSFetchRequest<Classroom> = Classroom.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", id.uuidString)
        fetchRequest.predicate = predicate
        
        do {
            if let fetchedClassroom = try viewContext.fetch(fetchRequest).first {
                viewContext.delete(fetchedClassroom)
                saveContext()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
