import UIKit


final class ClassroomTableViewController: UIViewController {
    
    //MARK: - Private Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        return tableView
    }()
    
    private var viewModel: ClassroomTableViewModelProtocol = ClassroomTableViewModel(storageManager: CoreDataManager.shared)
    private var cellDataSource: [ClassroomCellViewModel] = []
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}


//MARK: - Private Methods
private extension ClassroomTableViewController {
    
    func setupView(){
        view.backgroundColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(createClassroom))
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
        tableView.register(ClassroomViewCell.self, forCellReuseIdentifier: ClassroomViewCell.reuseIdentifier)
    }
    
    func bindViewModel() {
        viewModel.cellDataClassrooms.bind({[weak self] cellData in
            guard let self, let cellData else { return }
            DispatchQueue.main.async {
                self.cellDataSource = cellData
                self.tableView.reloadData()
            }
        })
        
    }
    
    @objc
    func createClassroom() {
        let classroom = ClassroomViewModel()
        let alert = UIAlertController(title: "Аудитория", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = ""
            textField.placeholder = "Этаж"
        }
        alert.addTextField { (textField1) in
            textField1.text = ""
            textField1.placeholder = "Номер"
        }
        let save = UIAlertAction(title: "Сохранить", style: .default) { [weak alert, classroom, weak self] _ in
            if let newFloor = alert?.textFields?.first?.text, let newNumber = alert?.textFields?.last?.text, let self {
                classroom.floor = Int16(newFloor)
                classroom.number = Int16(newNumber)
                classroom.save()
                self.viewModel.setupClassrooms()
            }
        }
        alert.addAction(save)
        self.present(alert, animated: true)
    }
    
    func presentClassroom(_ classroomCell: ClassroomCellViewModel) {
        let classroom = ClassroomViewModel(id: classroomCell.id)
        let alert = UIAlertController(title: "Аудитория", message: nil, preferredStyle: .alert)
        alert.addTextField { [classroom] (textField) in
            if let floor = classroom.floor {
                textField.text = String(floor)
            }
            else {
                textField.text = ""
            }
            textField.placeholder = "Этаж"
        }
        alert.addTextField { [classroom] (textField1) in
            if let number = classroom.number {
                textField1.text = String(number)
            }
            else {
                textField1.text = ""
            }
            textField1.placeholder = "Номер"
        }
        let save = UIAlertAction(title: "Сохранить", style: .default) { [weak alert, classroom, weak self] _ in
            if let newFloor = alert?.textFields?.first?.text, let newNumber = alert?.textFields?.last?.text, let self {
                classroom.floor = Int16(newFloor)
                classroom.number = Int16(newNumber)
                classroom.save()
                self.viewModel.setupClassrooms()
            }
        }
        alert.addAction(save)
        self.present(alert, animated: true)
    }
}


//MARK: - UITableViewDelegate
extension ClassroomTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentClassroom(cellDataSource[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.delete(id: cellDataSource[indexPath.row].id)
            viewModel.setupClassrooms()
        }
    }
    
}

//MARK: - UITableViewDataSource
extension ClassroomTableViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ClassroomViewCell.reuseIdentifier, for: indexPath) as? ClassroomViewCell else { return UITableViewCell() }
            let cellViewModel = cellDataSource[indexPath.row]
            cell.setupCell(viewModel: cellViewModel)
        return cell
    }
    
}

