import UIKit


final class TabBarController: UITabBarController {
    
    let profileViewController = ProfileViewController()
    let scheduleViewController = ScheduleViewController()
    var createViewController = LessonViewController()
    
    //MARK: - Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Private methods
    private func setup() {
        setApperance()
        setVC()
        self.delegate = self
    }
    
    private func setVC() {
        
        let profileNavigation = UINavigationController(rootViewController: profileViewController)
        
        scheduleViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "calendar"), selectedImage: nil)
        createViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "plus.app"), selectedImage: nil)
        profileNavigation.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.crop.circle"), selectedImage: nil)
        profileNavigation.navigationBar.tintColor = .white
        
        
        setViewControllers([scheduleViewController, createViewController, profileNavigation], animated: true)
    }
    
    private func setApperance() {
        
        let x: CGFloat = 30
        let y: CGFloat = 5
        let height = tabBar.bounds.height + y * 2
        let width = tabBar.bounds.width - x * 2
        
        let roundLayer = CAShapeLayer()

        let bezierPath = UIBezierPath(roundedRect: CGRect(
                x: x,
                y: tabBar.bounds.minY - 2 * y,
                width: width,
                height: height
            ),
            cornerRadius: height / 2
        )
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 3
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.back.cgColor
        
        tabBar.tintColor = .white
        tabBar.barTintColor = .gray
        
    }
    
}


//MARK: - UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate {
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is LessonViewController {
            let modalViewController = LessonViewController(viewModel: LessonViewModel(idLesson: nil, storageManager: CoreDataManager.shared))
            modalViewController.modalPresentationStyle = .formSheet
            modalViewController.delegate = scheduleViewController
            tabBarController.present(modalViewController, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
}
