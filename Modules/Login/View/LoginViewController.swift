import UIKit

class LoginViewController: UIViewController {
    
    private let presenter: LoginPresenterProtocol
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = UIColor(named: "redDark")
        label.font = UIFont(descriptor: UIFontDescriptor(name: "Amaranth-Bold", size: 22), size: 22)
        label.textAlignment = .center
        return label
    }()
    
    init (presenter: LoginPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "white")
        setUpTitleLabel()
    }
    
    private func setUpTitleLabel() {
        self.view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
}

extension LoginViewController: LoginViewProtocol{
    // TODO: Implement View Output Methods
}
