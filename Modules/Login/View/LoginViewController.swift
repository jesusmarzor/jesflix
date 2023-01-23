import UIKit

class LoginViewController: UIViewController {
    private let presenter: LoginPresenterProtocol

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = String.getLabelForKey("common_login")
        label.textColor = UIColor.theme(.redDark)
        label.font = UIFont.theme(.bold30)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var emailTextField: JesflixTextField = {
        let textField = JesflixTextField()
        textField.configure(placeholder: String.getLabelForKey("common_email"))
        return textField
    }()
    
    private lazy var passwordTextField: JesflixTextField = {
        let textField = JesflixTextField()
        textField.configure(placeholder: String.getLabelForKey("common_password"))
        return textField
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
        self.view.backgroundColor = UIColor.theme(.white)
        setUpTitleLabel()
        setUpEmailTextField()
        setUpPasswordTextField()
    }

    private func setUpTitleLabel() {
        self.view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    private func setUpEmailTextField() {
        self.view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 16).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setUpPasswordTextField() {
        self.view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 16).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -16).isActive = true
    }
}

extension LoginViewController: LoginViewProtocol {
    // TODO: Implement View Output Methods
}
