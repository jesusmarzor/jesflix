import UIKit

class JesflixTextField: UITextField {
    private lazy var eyeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = UIColor.theme(.primary)
        button.addTarget(self, action: #selector(didTapEyeButton), for: .touchUpInside)
        button.contentMode = .center
        return button
    }()
    
    func configure(type: JesflixTextFieldType, heightSize: JesflixHeightSize, placeholder: String) {
        self.placeholder = placeholder
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.theme(.primary).cgColor
        self.layer.cornerRadius = 5
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
        self.autocapitalizationType = .none
        switch type {
        case .mail:
            self.keyboardType = .emailAddress
            
        case .password:
            self.isSecureTextEntry = true
            setUpEyeButtonLayout(height: heightSize.rawValue)
            
        default:
            break
        }
        setUpHeightButton(heightSize.rawValue)
    }
    
    private func setUpHeightButton(_ height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setUpEyeButtonLayout(height: CGFloat) {
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        eyeButton.widthAnchor.constraint(equalToConstant: height + JesflixSize.marginXS.rawValue).isActive = true
        rightView = eyeButton
    }
    
    @objc
    private func didTapEyeButton() {
        eyeButton.setImage(UIImage(systemName: (isSecureTextEntry) ? "eye.slash" : "eye"), for: .normal)
        isSecureTextEntry = !isSecureTextEntry
    }
}

enum JesflixTextFieldType {
    case text
    case mail
    case password
}
