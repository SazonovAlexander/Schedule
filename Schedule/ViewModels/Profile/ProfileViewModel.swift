import Foundation



final class ProfileViewModel {
    
    static let imageUrl: String = "scheduleProfileImage"
    
    private let profileStorage: ProfileStorage
    
    var name: Observable<String>
    
    init(profileStorage: ProfileStorage = ProfileStorage.shared,
         name: Observable<String> = Observable(value: nil)) {
        self.profileStorage = profileStorage
        self.name = name
        getProfileInfo()
    }
    
    private func getProfileInfo() {
        name.value = profileStorage.name != nil ? profileStorage.name : "Ваше имя"
    }
    
    
    func setName(_ newName: String) {
        profileStorage.name = newName
        getProfileInfo()
    }
    
    
    
}
