import UIKit


final class TypeLessonTableViewController: UIViewController {
    
    //MARK: - Private Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        return tableView
    }()
    
    private var viewModel: TypeLessonTableViewModelProtocol = TypeLessonTableViewModel(storageManager: CoreDataManager.shared)
    private var cellDataSource: [TypeLessonCellViewModel] = []
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}


//MARK: - Private Methods
private extension TypeLessonTableViewController {
    
    func setupView(){
        view.backgroundColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(createTypeLesson))
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
        tableView.register(TypeLessonViewCell.self, forCellReuseIdentifier: TypeLessonViewCell.reuseIdentifier)
    }
    
    func bindViewModel() {
        viewModel.cellDataType.bind({[weak self] cellData in
            guard let self, let cellData else { return }
            DispatchQueue.main.async {
                self.cellDataSource = cellData
                self.tableView.reloadData()
            }
        })
        
    }
    
    @objc
    func createTypeLesson() {
        let type = TypeLessonViewModel()
        let alert = UIAlertController(title: "Тип занятия", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = ""
            textField.placeholder = "Тип"
        }
        let save = UIAlertAction(title: "Сохранить", style: .default) { [weak alert, type, weak self] _ in
            if let newType = alert?.textFields?.first?.text, let self {
                type.type = newType
                type.save()
                self.viewModel.setupTypeLesson()
            }
        }
        alert.addAction(save)
        self.present(alert, animated: true)
    }
    
    func presentTypeLesson(_ typeCell: TypeLessonCellViewModel) {
        let type = TypeLessonViewModel(id: typeCell.id)
        let alert = UIAlertController(title: "Тип занятия", message: nil, preferredStyle: .alert)
        alert.addTextField { [type] (textField) in
            if let typeText = type.type {
                textField.text = typeText
            }
            else {
                textField.text = ""
            }
            textField.placeholder = "Тип"
        }
        
        let save = UIAlertAction(title: "Сохранить", style: .default) { [weak alert, type, weak self] _ in
            if let newType = alert?.textFields?.first?.text, let self {
                type.type = newType
                type.save()
                self.viewModel.setupTypeLesson()
            }
        }
        alert.addAction(save)
        self.present(alert, animated: true)
    }
}


//MARK: - UITableViewDelegate
extension TypeLessonTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentTypeLesson(cellDataSource[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.delete(id: cellDataSource[indexPath.row].id)
            viewModel.setupTypeLesson()
        }
    }
    
}

//MARK: - UITableViewDataSource
extension TypeLessonTableViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TypeLessonViewCell.reuseIdentifier, for: indexPath) as? TypeLessonViewCell else { return UITableViewCell() }
            let cellViewModel = cellDataSource[indexPath.row]
            cell.setupCell(viewModel: cellViewModel)
        return cell
    }
    
}

