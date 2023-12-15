import UIKit


final class ProfileImageButton: UIButton {
    

    var myImageView: UIImageView
    
    init(myImageView: UIImageView) {
        self.myImageView = myImageView
        super.init(frame: .null)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        tintColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 60
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor

        setupMyImageView()
        addSubviews()
        activateConstraints()
    }
    
    private func setupMyImageView() {
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(ProfileViewModel.imageUrl)
        if let imageData = try? Data(contentsOf: path) {
            if let image = UIImage(data: imageData) {
                myImageView.image = image
            }
        }
    }
    
    private func addSubviews() {
        addSubview(myImageView)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 120),
            widthAnchor.constraint(equalToConstant: 120),
            myImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            myImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            myImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            myImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1)
        ])
    }
    
    
    
}
