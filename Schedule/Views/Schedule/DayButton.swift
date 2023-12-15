import UIKit


final class DayButton: UIButton {
    
    
    //MARK: - Public Properties
    var isCurrent: Bool {
        willSet {
            backgroundColor = newValue ? .red : .black
        }
    }
    
    let day: Days
    
    //MARK: - Private Properties
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Initializers
    init(day: Days, isCurrent: Bool) {
        self.isCurrent = isCurrent
        self.day = day
        super.init(frame: .null)
        setupButton(day)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func setupButton(_ day: Days){
        label.text = String(describing: day.rawValue.first!)
        layer.cornerRadius = 22
        clipsToBounds = true
        layer.masksToBounds = true
        
        addSubviews()
        activateConstraints()
        
    }
    
    private func addSubviews(){
        addSubview(label)
    }
    
    private func activateConstraints(){
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            heightAnchor.constraint(equalToConstant: 44),
            widthAnchor.constraint(equalToConstant: 44)
        ])
    }
    
}
