import UIKit

class JesflixTextField: UITextField {
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
        self.isSecureTextEntry = (type == .password)
        setUpHeightButton(heightSize.rawValue)
    }
    
    func setUpHeightButton(_ height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        endEditing(true)
    }
}

enum JesflixTextFieldType {
    case text
    case password
}
