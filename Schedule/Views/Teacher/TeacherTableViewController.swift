import UIKit


final class TeacherTableViewController: UIViewController {
    
    //MARK: - Private Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        return tableView
    }()
    
    private var viewModel: TeacherTableViewModelProtocol = TeacherTableViewModel(storageManager: CoreDataManager.shared)
    private var cellDataSource: [TeacherCellViewModel] = []
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}


//MARK: - Private Methods
private extension TeacherTableViewController {
    
    func setupView(){
        view.backgroundColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(createTeacher))
        setupTableView()
        addSubviews()
        activateConstraints()
        bindViewModel()
    }
    
    func addSubviews(){
        view.addSubview(tableView)
    }
    
    func activateConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        registerCell()
    }
    
    func registerCell() {
        tableView.register(TeacherViewCell.self, forCellReuseIdentifier: TeacherViewCell.reuseIdentifier)
    }
    
    func bindViewModel() {
        viewModel.cellDataTeachers.bind({[weak self] cellData in
            guard let self, let cellData else { return }
            DispatchQueue.main.async {
                self.cellDataSource = cellData
                self.tableView.reloadData()
            }
        })
        
    }
    
    @objc
    func createTeacher() {
        let teacher = TeacherViewModel()
        let alert = UIAlertController(title: "Преподаватель", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = "Имя"
        }
        alert.addTextField { (textField) in
            textField.text = "Телефон"
        }
        let save = UIAlertAction(title: "Сохранить", style: .default) { [weak alert, teacher, weak self] _ in
            if let newName = alert?.textFields?.first?.text, let self {
                teacher.name = newName
                teacher.phone = alert?.textFields?.last?.text
                teacher.save()
                self.viewModel.setupTeachers()
            }
        }
        alert.addAction(save)
        self.present(alert, animated: true)
    }
    
    func presentTeacher(_ teacherCell: TeacherCellViewModel) {
        let teacher = TeacherViewModel(id: teacherCell.id)
        let alert = UIAlertController(title: "Преподаватель", message: nil, preferredStyle: .alert)
        alert.addTextField { [teacher] (textField) in
            textField.text = teacher.name
        }
        alert.addTextField { [teacher] (textField1) in
            textField1.text = teacher.phone
        }
        let save = UIAlertAction(title: "Сохранить", style: .default) { [weak alert, teacher, weak self] _ in
            if let newName = alert?.textFields?.first?.text, let self {
                teacher.name = newName
                teacher.phone = alert?.textFields?.last?.text
                teacher.save()
                self.viewModel.setupTeachers()
            }
        }
        alert.addAction(save)
        self.present(alert, animated: true)
    }
}


//MARK: - UITableViewDelegate
extension TeacherTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentTeacher(cellDataSource[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.delete(id: cellDataSource[indexPath.row].id)
            viewModel.setupTeachers()
        }
    }
    
}

//MARK: - UITableViewDataSource
extension TeacherTableViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeacherViewCell.reuseIdentifier, for: indexPath) as? TeacherViewCell else { return UITableViewCell() }
            let cellViewModel = cellDataSource[indexPath.row]
            cell.setupCell(viewModel: cellViewModel)
        return cell
    }
    
}
