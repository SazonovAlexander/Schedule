import Foundation


final class ProfileStorage {
    
    static let shared = ProfileStorage()
    
    private init() {}
    
    static let nameKey = "name"
    
    var name: String? {
        get {
            UserDefaults.standard.string(forKey: ProfileStorage.nameKey)
        }
        set (newName){
            UserDefaults.standard.setValue(newName, forKey: ProfileStorage.nameKey)
        }
    }
    
}
