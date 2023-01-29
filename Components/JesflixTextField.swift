import UIKit

class JesflixTextField: UITextField {
    func configure(type: TextFieldType, placeholder: String) {
        self.placeholder = placeholder
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 48).isActive = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.theme(.gray).cgColor
        self.layer.cornerRadius = 5
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
        self.autocapitalizationType = .none
        self.isSecureTextEntry = (type == .password)
    }
}

enum TextFieldType {
    case text
    case password
}
