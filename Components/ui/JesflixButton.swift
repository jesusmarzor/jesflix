import UIKit

class JesflixButton: UIButton {
    func configure(heightSize: JesflixHeightSize, text: String, target: Any?, action: Selector) {
        self.setTitle(text, for: .normal)
        self.backgroundColor = UIColor.theme(.primary)
        self.layer.cornerRadius = 5
        self.tintColor = UIColor.theme(.letter)
        self.addTarget(target, action: action, for: .touchUpInside)
        setUpHeightButton(heightSize.rawValue)
    }
    
    func setUpHeightButton(_ height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}

