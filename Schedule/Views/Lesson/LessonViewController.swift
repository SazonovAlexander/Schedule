import UIKit


final class LessonViewController : UIViewController {
    
    //Public properties
    var delegate: UpdateScheduleDelegate?
    
    //MARK: - Private properties
    private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = true
        scroll.alwaysBounceVertical = true
        return scroll
    }()
    
    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Занятие"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    private var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .darkGray
        textField.attributedPlaceholder = NSAttributedString(string: "Название", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = .white
        textField.layer.cornerRadius = 10
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clipsToBounds = true
        return textField
    }()

    private var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.backgroundColor = .green
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    private var labelTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Время"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    private var startTimeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" Начало 8:00", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private var endTimeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" Конец 8:00", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private var startTimePickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.setValue(UIColor.white, forKeyPath: "textColor")
        return picker
    }()
    
    private var endTimePickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.setValue(UIColor.white, forKeyPath: "textColor")
        return picker
    }()
    
    private var labelOptional: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Необязательные параметры"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    private var colorButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" Цвет", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private var colorPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.setValue(UIColor.white, forKeyPath: "textColor")
        return picker
    }()
    
    private var teacherButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" Преподаватель", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private var teacherPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.setValue(UIColor.white, forKeyPath: "textColor")
        return picker
    }()
    
    private var dayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private var dayPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.setValue(UIColor.white, forKeyPath: "textColor")
        return picker
    }()
    
    private var classroomButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" Аудитория", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private var classroomPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.setValue(UIColor.white, forKeyPath: "textColor")
        return picker
    }()
    
    private var typeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" Тип занятия", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private var typePickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.setValue(UIColor.white, forKeyPath: "textColor")
        return picker
    }()
    
    
    private var viewModel: LessonViewModelProtocol

    
    //MARK: - Initializers
    init(viewModel: LessonViewModelProtocol = LessonViewModel(idLesson: nil, storageManager: CoreDataManager.shared)) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
        
}


//MARK: - Private methods
private extension LessonViewController {
    
    func setup() {
        view.backgroundColor = .back
        addSubviews()
        activateConstraints()
        setupPickers()
        addActions()
        bindViewModel()
        setupData()
    }
    
    func setupData() {
        self.nameTextField.text = viewModel.name
        nameTextField.delegate = self
    }
    
    func bindViewModel() {
        viewModel.startTimeHour.bind({ [weak self] hour in
            guard let self, let hour else { return }
            DispatchQueue.main.async {
                self.startTimeButton.setTitle(" Начало \(hour):\(self.viewModel.startTimeMinut.value ?? "")", for: .normal)
            }
        })
        viewModel.startTimeMinut.bind({ [weak self] minut in
            guard let self, let minut else { return }
            DispatchQueue.main.async {
                self.startTimeButton.setTitle(" Начало \(self.viewModel.startTimeHour.value ?? ""):\(minut)", for: .normal)
            }
        })
        viewModel.endTimeHour.bind({ [weak self] hour in
            guard let self, let hour else { return }
            DispatchQueue.main.async {
                self.endTimeButton.setTitle(" Конец \(hour):\(self.viewModel.endTimeMinut.value ?? "")", for: .normal)
            }
        })
        viewModel.endTimeMinut.bind({ [weak self] minut in
            guard let self, let minut else { return }
            DispatchQueue.main.async {
                self.endTimeButton.setTitle(" Конец \(self.viewModel.endTimeHour.value ?? ""):\(minut)", for: .normal)
            }
        })
        viewModel.selectedColor.bind({ [weak self] selectedColor in
            guard let self, let selectedColor else { return }
            DispatchQueue.main.async {
                self.colorButton.backgroundColor = UIColor.colorFromString(selectedColor)
            }
        })
        viewModel.selectedDay.bind({ [weak self] selectedDay in
            guard let self, let selectedDay else { return }
            DispatchQueue.main.async {
                self.dayButton.setTitle(" \(selectedDay.rawValue)", for: .normal)
            }
        })
        viewModel.selectedTeacherId.bind({ [weak self] selectedTeacherId in
            guard let self, let selectedTeacherId else { return }
            DispatchQueue.main.async {
                self.teacherButton.setTitle(" \(self.viewModel.teachers.first(where: {$0.id == selectedTeacherId})?.description ?? "")", for: .normal)
            }
        })
        viewModel.selectedClassroomId.bind({ [weak self] selectedClassroomId in
            guard let self, let selectedClassroomId else { return }
            DispatchQueue.main.async {
                self.classroomButton.setTitle(" \(self.viewModel.classrooms.first(where: {$0.id == selectedClassroomId})?.description ?? "")", for: .normal)
            }
        })
        viewModel.selectedTypeId.bind({ [weak self] selectedTypeId in
            guard let self, let selectedTypeId else { return }
            DispatchQueue.main.async {
                self.typeButton.setTitle(" \(self.viewModel.types.first(where: {$0.id == selectedTypeId})?.description ?? "")", for: .normal)
            }
        })
        
    }
    
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(labelTitle)
        contentView.addSubview(nameTextField)
        contentView.addSubview(saveButton)
        contentView.addSubview(startTimeButton)
        contentView.addSubview(endTimeButton)
        contentView.addSubview(colorButton)
        contentView.addSubview(teacherButton)
        contentView.addSubview(dayButton)
        contentView.addSubview(classroomButton)
        contentView.addSubview(typeButton)
        contentView.addSubview(labelTime)
        contentView.addSubview(labelOptional)
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            labelTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            labelTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 60),
            startTimeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            startTimeButton.topAnchor.constraint(equalTo: labelTime.bottomAnchor, constant: 20),
            startTimeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            startTimeButton.heightAnchor.constraint(equalToConstant: 60),
            labelTime.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            labelTime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            endTimeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            endTimeButton.topAnchor.constraint(equalTo: startTimeButton.bottomAnchor, constant:  20),
            endTimeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            endTimeButton.heightAnchor.constraint(equalToConstant: 60),
            colorButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            colorButton.topAnchor.constraint(equalTo: dayButton.bottomAnchor, constant:  60),
            colorButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            colorButton.heightAnchor.constraint(equalToConstant: 60),
            labelOptional.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 40),
            labelOptional.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:  20),
            dayButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dayButton.topAnchor.constraint(equalTo: endTimeButton.bottomAnchor, constant:  20),
            dayButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            dayButton.heightAnchor.constraint(equalToConstant: 60),
            teacherButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            teacherButton.topAnchor.constraint(equalTo: labelOptional.bottomAnchor, constant:  20),
            teacherButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            teacherButton.heightAnchor.constraint(equalToConstant: 60),
            classroomButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            classroomButton.topAnchor.constraint(equalTo: teacherButton.bottomAnchor, constant:  20),
            classroomButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            classroomButton.heightAnchor.constraint(equalToConstant: 60),
            typeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            typeButton.topAnchor.constraint(equalTo: classroomButton.bottomAnchor, constant:  20),
            typeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            typeButton.heightAnchor.constraint(equalToConstant: 60),
            saveButton.topAnchor.constraint(equalTo: typeButton.bottomAnchor, constant: 40),
            saveButton.heightAnchor.constraint(equalToConstant: 60),
            saveButton.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupPickers() {
        startTimePickerView.delegate = self
        startTimePickerView.dataSource = self
        endTimePickerView.delegate = self
        endTimePickerView.dataSource = self
        colorPickerView.dataSource = self
        colorPickerView.delegate = self
        colorPickerView.selectRow(2, inComponent: 0, animated: false)
        teacherPickerView.dataSource = self
        teacherPickerView.delegate = self
        dayPickerView.dataSource = self
        dayPickerView.delegate = self
        classroomPickerView.dataSource = self
        classroomPickerView.delegate = self
        typePickerView.dataSource = self
        typePickerView.delegate = self
    }
    
    func addActions() {
        startTimeButton.addTarget(self, action: #selector(Self.didTapStartTimeButton), for: .touchUpInside)
        endTimeButton.addTarget(self, action: #selector(Self.didTapEndTimeButton), for: .touchUpInside)
        colorButton.addTarget(self, action: #selector(Self.didTapColorButton), for: .touchUpInside)
        teacherButton.addTarget(self, action: #selector(Self.didTapTeacherButton), for: .touchUpInside)
        dayButton.addTarget(self, action: #selector(Self.didTapDayButton), for: .touchUpInside)
        classroomButton.addTarget(self, action: #selector(Self.didTapClassroomButton), for: .touchUpInside)
        typeButton.addTarget(self, action: #selector(Self.didTapTypeButton), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(Self.didTapSaveButton), for: .touchUpInside)
    }
    
    @objc
    func didTapStartTimeButton(_ sender: UIButton) {
        popoverPickerView(startTimePickerView, sourceView: sender, size: CGSize(width: view.frame.width / 2, height: view.frame.height / 4))
    }
    
    @objc
    func didTapEndTimeButton(_ sender: UIButton) {
        popoverPickerView(endTimePickerView, sourceView: sender, size: CGSize(width: view.frame.width / 2, height: view.frame.height / 4))
    }
    
    @objc
    func didTapColorButton(_ sender: UIButton) {
        popoverPickerView(colorPickerView, sourceView: sender, size: CGSize(width: view.frame.width / 2, height: view.frame.height / 4))
    }
    
    @objc
    func didTapTeacherButton(_ sender: UIButton) {
        popoverPickerView(teacherPickerView, sourceView: sender, size: CGSize(width: view.frame.width * 3 / 4, height: view.frame.height / 4))
    }
    
    @objc 
    func didTapDayButton(_ sender: UIButton) {
        popoverPickerView(dayPickerView, sourceView: sender, size: CGSize(width: view.frame.width * 3 / 4, height: view.frame.height / 4))
    }
    
    @objc
    func didTapClassroomButton(_ sender: UIButton) {
        popoverPickerView(classroomPickerView, sourceView: sender, size: CGSize(width: view.frame.width * 3 / 4, height: view.frame.height / 4))
    }
    
    @objc
    func didTapTypeButton(_ sender: UIButton) {
        popoverPickerView(typePickerView, sourceView: sender, size: CGSize(width: view.frame.width * 3 / 4, height: view.frame.height / 4))
    }

    
    func popoverPickerView(_ pickerView: UIPickerView, sourceView: UIView, size: CGSize) {
        let popoverContent = UIViewController()
        popoverContent.view = pickerView
        popoverContent.view.backgroundColor = .black
        popoverContent.modalPresentationStyle = .popover
        popoverContent.preferredContentSize = size
        
        guard let vc = popoverContent.popoverPresentationController else { return }
        vc.delegate = self
        vc.sourceView = sourceView
        present(popoverContent, animated: true)
    }
    
    @objc
    func didTapSaveButton() {
        viewModel.name = nameTextField.text
        viewModel.save()
        delegate?.update(day: viewModel.selectedDay.value ?? .monday)
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - UIPickerViewDataSource
extension LessonViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView {
        case startTimePickerView:
            return 2
        case endTimePickerView:
            return 2
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count: Int = 0
        switch pickerView {
        case startTimePickerView:
            if component == 0 {
                count = viewModel.hours.count
            }
            if component == 1 {
                count = viewModel.minuts.count
            }
        case endTimePickerView:
            if component == 0 {
                count = viewModel.hours.count
            }
            if component == 1 {
                count = viewModel.minuts.count
            }
        case colorPickerView:
            count = viewModel.colors.count
        case teacherPickerView:
            count = viewModel.teachers.count
        case dayPickerView:
            count = viewModel.days.count
        case classroomPickerView:
            count = viewModel.classrooms.count
        case typePickerView:
            count = viewModel.types.count
        default:
            count = 0
        }
        return count
    }
    
}

//MARK: - UIPickerViewDelegate
extension LessonViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case startTimePickerView:
                if component == 0 {
                    viewModel.startTimeHour.value = viewModel.hours[row]
                }
                if component == 1 {
                    viewModel.startTimeMinut.value = viewModel.minuts[row]
                }
        case endTimePickerView:
            if component == 0 {
                viewModel.endTimeHour.value = viewModel.hours[row]
            }
            if component == 1 {
                viewModel.endTimeMinut.value = viewModel.minuts[row]
            }
        case colorPickerView:
            viewModel.selectedColor.value = viewModel.colors[Array(viewModel.colors.keys).sorted()[row]]
        case teacherPickerView:
            viewModel.selectedTeacherId.value = viewModel.teachers[row].id
        case dayPickerView:
            viewModel.selectedDay.value = viewModel.days[row]
        case classroomPickerView:
            viewModel.selectedClassroomId.value = viewModel.classrooms[row].id
        case typePickerView:
            viewModel.selectedTypeId.value = viewModel.types[row].id
        default:
            return
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case startTimePickerView:
            if component == 0 {
                return viewModel.hours[row]
            }
            else {
                return viewModel.minuts[row]
            }
        case endTimePickerView:
            if component == 0 {
                return viewModel.hours[row]
            }
            else {
                return viewModel.minuts[row]
            }
        case colorPickerView:
            return Array(viewModel.colors.keys).sorted()[row]
        case teacherPickerView:
            return viewModel.teachers[row].description
        case dayPickerView:
            return viewModel.days[row].rawValue
        case classroomPickerView:
            return viewModel.classrooms[row].description
        case typePickerView:
            return viewModel.types[row].description
        default:
            return nil
        }
    }
    
}


//MARK: - UIPopoverPresentationControllerDelegate
extension LessonViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
        }
    
}


//MARK: - UITextFieldDelegate
extension LessonViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
  
}



