import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {
    private let presenter: LoginPresenterProtocol
    private let context: LAContext

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = String.getLabelForKey("common_login")
        label.textColor = UIColor.theme(.letter)
        label.font = UIFont.theme(.bold30)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var welcomeEmailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.theme(.primary)
        label.font = UIFont.theme(.regular16)
        label.isHidden = true
        return label
    }()
    
    private lazy var signOutLabel: UILabel = {
        let label = UILabel()
        label.text = String.getLabelForKey("login_sign_out_button")
        label.textColor = UIColor.theme(.primary)
        label.font = UIFont.theme(.regular16)
        label.isHidden = true
        return label
    }()
    
    private lazy var emailTextField: JesflixTextField = {
        let textField = JesflixTextField()
        textField.configure(type: .mail, heightSize: .L, placeholder: String.getLabelForKey("common_email"))
        return textField
    }()
    
    private lazy var passwordTextField: JesflixTextField = {
        let textField = JesflixTextField()
        textField.configure(type: .password, heightSize: .L, placeholder: String.getLabelForKey("common_password"))
        return textField
    }()
    
    private lazy var biometricsButton: JesflixButton = {
        let button = JesflixButton()
        button.configure(heightSize: .L, text: String.getLabelForKey("common_use_biometrics"), target: self, action: #selector(didTapBiometricsButton))
        button.isHidden = true
        return button
    }()
    
    private lazy var loginButton: JesflixButton = {
        let button = JesflixButton()
        button.configure(heightSize: .L, text: String.getLabelForKey("common_login"), target: self, action: #selector(didTapLoginButton))
        return button
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, welcomeEmailLabel, emailTextField, passwordTextField, signOutLabel, UIView(), biometricsButton, loginButton])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = JesflixSize.marginS.rawValue
        return stackView
    }()

    init (presenter: LoginPresenterProtocol) {
        self.presenter = presenter
        self.context = LAContext()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.theme(.body)
        self.hideKeyboardWhenTappedAround()
        setUpMainStackView()
        configureMainStackView()
    }
    
    private func setUpMainStackView() {
        view.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: JesflixSize.marginM.rawValue).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: JesflixSize.marginS.rawValue).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -JesflixSize.marginS.rawValue).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -JesflixSize.marginL.rawValue).isActive = true
    }
    
    private func configureMainStackView() {
        if let email = presenter.thereIsAnUserConected() {
            welcomeEmailLabel.text = String.getLabelForKey("login_welcome").replacingOccurrences(of: "@", with: email)
            emailTextField.text = email
            welcomeEmailLabel.isHidden = false
            signOutLabel.isHidden = false
            emailTextField.isHidden = true
            biometricsButton.isHidden = false
            setUpSignOutLabelLayout()
            if presenter.isUsedBiometrics() {
                useBiometrics()
            }
        } else {
            emailTextField.text = ""
            welcomeEmailLabel.isHidden = true
            signOutLabel.isHidden = true
            emailTextField.isHidden = false
            biometricsButton.isHidden = true
        }
    }
    
    private func setUpSignOutLabelLayout() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapSignOutLabel))
        signOutLabel.isUserInteractionEnabled = true
        signOutLabel.addGestureRecognizer(tap)
    }
    
    private func useBiometrics() {
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = String.getLabelForKey("login_biometrics_reason")
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        return
                    }
                    self.presenter.loginUserWithBiometrics()
                }
            }
        }
    }
    
    @objc
    private func didTapLoginButton() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            presenter.loginUser(email: email, password: password)
        }
    }
    
    @objc
    private func didTapBiometricsButton() {
        useBiometrics()
        presenter.setIsUsedBiometrics(with: true)
    }
    
    @objc
    private func didTapSignOutLabel() {
        presenter.signOut()
        viewDidLoad()
    }
}

extension LoginViewController: LoginViewProtocol {
    // TODO: Implement View Output Methods
}
