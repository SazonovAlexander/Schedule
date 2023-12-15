import UIKit

final class ScheduleViewController: UIViewController {

    
    //MARK: - Private Properties
    private let dayButtons: [DayButton] = {
        let days = Days.allCases.map({DayButton(day: $0, isCurrent: false)})
        days.first?.isCurrent.toggle()
        return days
    }()
    
    private let daysBarStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        return tableView
    }()
    
    private var viewModel: ScheduleViewModelProtocol = ScheduleViewModel(storageManager: CoreDataManager.shared)
    private var cellDataSource: [LessonCellViewModel] = []
    
    //MARK: - Override methods
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}


//MARK: - Private Methods
private extension ScheduleViewController {
    
    func setupView(){
        view.backgroundColor = .black
        viewModel.currentDay = .monday
        setupTableView()
        setupStack()
        addSubviews()
        activateConstraints()
        bindViewModel()
        addActions()
    }
    
    func setupStack(){
        dayButtons.forEach({daysBarStack.addArrangedSubview($0)})
    }
    
    func addSubviews(){
        view.addSubview(daysBarStack)
        view.addSubview(tableView)
    }
    
    func activateConstraints(){
        NSLayoutConstraint.activate([
            daysBarStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            daysBarStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            daysBarStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: daysBarStack.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func addActions(){
        dayButtons.forEach({$0.addTarget(self, action: #selector(Self.selectCurrentDay), for: .touchUpInside)})
    }
    
    func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        registerCell()
    }
    
    func registerCell() {
        tableView.register(LessonViewCell.self, forCellReuseIdentifier: LessonViewCell.reuseIdentifier)
    }
    
    func bindViewModel() {
        viewModel.cellDataCurrentDay.bind({[weak self] cellData in
            guard let self, let cellData else { return }
            DispatchQueue.main.async {
                self.cellDataSource = cellData
                self.tableView.reloadData()
            }
        })
        
    }
    
    @objc
    func selectCurrentDay(_ sender: DayButton){
        updateCurrentDay(day: sender.day)
    }
    
    func updateCurrentDay(day: Days) {
        viewModel.currentDay = day
        self.dayButtons.first(where: {$0.isCurrent})?.isCurrent.toggle()
        self.dayButtons.first(where: {$0.day == day})!.isCurrent.toggle()
    }
    
    func presentLesson(_ lesson: LessonCellViewModel) {
        let lessonViewController = LessonViewController(viewModel: LessonViewModel(idLesson: lesson.id, storageManager: CoreDataManager.shared))
        lessonViewController.delegate = self
        lessonViewController.modalPresentationStyle = .formSheet
        present(lessonViewController, animated: true)
    }
}


//MARK: - UITableViewDelegate
extension ScheduleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentLesson(cellDataSource[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.delete(id: cellDataSource[indexPath.row].id)
            update(day: viewModel.currentDay ?? .monday)
        }
    }
    
}

//MARK: - UITableViewDataSource
extension ScheduleViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LessonViewCell.reuseIdentifier, for: indexPath) as? LessonViewCell else { return UITableViewCell() }
            let cellViewModel = cellDataSource[indexPath.row]
            cell.setupCell(viewModel: cellViewModel)
        return cell
    }
    
    
    
}


//MARK: - UpdateScheduleDelegate
extension ScheduleViewController: UpdateScheduleDelegate {

    func update(day: Days) {
        updateCurrentDay(day: day)
    }
    
}

