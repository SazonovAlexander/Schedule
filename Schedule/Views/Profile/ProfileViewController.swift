import UIKit


final class ProfileViewController: UIViewController, UINavigationControllerDelegate {
    
    
    //MARK: - Private properties
    private var profileImageButton: ProfileImageButton = ProfileImageButton(myImageView: UIImageView(image: UIImage(systemName: "person.circle.fill")))
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Ваше имя"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private var changeNameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        return button
    }()
    
    private var teachersButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Преподаватели", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    private var classroomsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Аудитории", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    private var typesLessonButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Типы занятий", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    private var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }()
    
    private let viewModel = ProfileViewModel()
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}


//MARK: - Private methods
private extension ProfileViewController {
    
    func setupView() {
        view.backgroundColor = .black
        navigationItem.backButtonTitle = ""
        imagePicker.delegate = self
        addSubviews()
        activateConstraints()
        addAction()
        bindViewModel()
    }
    
    func addSubviews() {
        
        view.addSubview(profileImageButton)
        view.addSubview(nameLabel)
        view.addSubview(changeNameButton)
        view.addSubview(teachersButton)
        view.addSubview(classroomsButton)
        view.addSubview(typesLessonButton)
        
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            profileImageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: profileImageButton.bottomAnchor, constant: 20),
            changeNameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            changeNameButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            teachersButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 40),
            teachersButton.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            teachersButton.trailingAnchor.constraint(equalTo: changeNameButton.trailingAnchor),
            teachersButton.heightAnchor.constraint(equalToConstant: 60),
            classroomsButton.topAnchor.constraint(equalTo: teachersButton.bottomAnchor, constant: 20),
            classroomsButton.leadingAnchor.constraint(equalTo: teachersButton.leadingAnchor),
            classroomsButton.trailingAnchor.constraint(equalTo: teachersButton.trailingAnchor),
            classroomsButton.heightAnchor.constraint(equalTo: teachersButton.heightAnchor, multiplier: 1),
            typesLessonButton.topAnchor.constraint(equalTo: classroomsButton.bottomAnchor, constant: 20),
            typesLessonButton.leadingAnchor.constraint(equalTo: teachersButton.leadingAnchor),
            typesLessonButton.trailingAnchor.constraint(equalTo: teachersButton.trailingAnchor),
            typesLessonButton.heightAnchor.constraint(equalTo: teachersButton.heightAnchor, multiplier: 1)
        ])
    }
    
    
    func bindViewModel() {
        viewModel.name.bind({ [weak self] newName in
            guard let self, let newName else { return }
            DispatchQueue.main.async {
                self.nameLabel.text = newName
            }
        })
    }
    
    func addAction() {
        changeNameButton.addTarget(self, action: #selector(Self.didTapChangeNameButton), for: .touchUpInside)
        profileImageButton.addTarget(self, action: #selector(Self.didTapProfileImageButton), for: .touchUpInside)
        teachersButton.addTarget(self, action: #selector(Self.didTapTeachersButton), for: .touchUpInside)
        classroomsButton.addTarget(self, action: #selector(Self.didTapClassroomButton), for: .touchUpInside)
        typesLessonButton.addTarget(self, action: #selector(Self.didTapTypeLessonButton), for: .touchUpInside)
    }
    
    @objc
    func didTapChangeNameButton() {
        alertChangeName()
    }
    
    @objc
    func didTapProfileImageButton() {
        present(imagePicker, animated: true)
    }
    
    @objc 
    func didTapTeachersButton() {
        navigationController?.pushViewController(TeacherTableViewController(), animated: true)
    }
    
    @objc
    func didTapClassroomButton() {
        navigationController?.pushViewController(ClassroomTableViewController(), animated: true)
    }
    
    @objc
    func didTapTypeLessonButton() {
        navigationController?.pushViewController(TypeLessonTableViewController(), animated: true)
    }
    
    func alertChangeName() {
        let alert = UIAlertController(title: nil, message: "Введите новое имя", preferredStyle: .alert)
        alert.addTextField { [weak self] (textField) in
            guard let self else { return }
            textField.text = self.nameLabel.text
        }
        let save = UIAlertAction(title: "Сохранить", style: .default) { [weak alert, weak self] _ in
            if let self, let newName = alert?.textFields?.first?.text {
                self.viewModel.setName(newName)
            }
        }
        alert.addAction(save)
        self.present(alert, animated: true)
    }
}


//MARK: - UIImagePickerControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(ProfileViewModel.imageUrl)
            if let jpeg = image.jpegData(compressionQuality: 1) {
                do {
                    try jpeg.write(to: path)
                    profileImageButton.myImageView.image = image
                } catch (let error) {
                    print(error.localizedDescription)
                }
                
            }
        }
        picker.dismiss(animated: true)
    }
    
}
