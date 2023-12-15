import UIKit


final class ClassroomViewCell: UITableViewCell {
    
    //MARK: - Constants
    static let reuseIdentifier = "classroomViewCell"
    
    //MARK: - Private Properties
    private let infoLabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 2
        return label
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
    func setupCell(viewModel: ClassroomCellViewModel) {
        infoLabel.text = viewModel.description
    }
    
    
    //MARK: - Private Methods
    private func setupViews(){
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        clipsToBounds = true
        selectionStyle = .none
        layer.borderWidth = 4
        layer.borderColor = UIColor.black.cgColor
        backgroundColor = .darkGray
        
        addSubview(infoLabel)

        
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            infoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            heightAnchor.constraint(equalTo: infoLabel.heightAnchor, multiplier: 1, constant: 20)
        ])
        
    }
}

