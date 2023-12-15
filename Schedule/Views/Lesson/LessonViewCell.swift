import UIKit


final class LessonViewCell: UITableViewCell {
    
    
    //MARK: - Constants
    static let reuseIdentifier = "lessonViewCell"
    
    //MARK: - Private Properties
    private let nameLabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let startTimeLabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let endTimeLabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let descriptionLabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let timeStack = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .center
        return stack
    }()
    
    private let infoStack = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Public Methods
    func setupCell(viewModel: LessonCellViewModel) {
        nameLabel.text = viewModel.name
        startTimeLabel.text = viewModel.startTime
        endTimeLabel.text = viewModel.endTime
        descriptionLabel.text = viewModel.description
        descriptionLabel.numberOfLines = viewModel.description.split(separator: "\n").count
        backgroundColor = UIColor.colorFromString(viewModel.color)
    }
    
    
    //MARK: - Private Methods
    private func setupViews(){
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        clipsToBounds = true
        selectionStyle = .none
        layer.borderWidth = 4
        layer.borderColor = UIColor.black.cgColor
        
        
        timeStack.addArrangedSubview(startTimeLabel)
        timeStack.addArrangedSubview(endTimeLabel)
        infoStack.addArrangedSubview(nameLabel)
        infoStack.addArrangedSubview(descriptionLabel)
        addSubview(infoStack)
        addSubview(timeStack)

        
        NSLayoutConstraint.activate([
            infoStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            infoStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            infoStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            timeStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            timeStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            timeStack.widthAnchor.constraint(equalTo: infoStack.widthAnchor, multiplier: 0.20),
            infoStack.trailingAnchor.constraint(equalTo: timeStack.leadingAnchor),
            heightAnchor.constraint(equalTo: infoStack.heightAnchor, multiplier: 1),
            infoStack.heightAnchor.constraint(equalToConstant: 110)
        ])
        
    }
    
    
}
