import UIKit

class IconLabelView: UIView {
    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.sizeThatFits(CGSize(width: 50, height: 50))
        view.tintColor = UIColor.theme(.primary)
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.theme(.letter)
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        backgroundColor = UIColor.theme(.body)
        setUpIconViewLayout()
        setUpLabelLayout()
    }
    
    func configure(image: UIImage, label: String) {
        self.iconView.image = image
        self.label.text = label
    }
    
    private func setUpIconViewLayout() {
        self.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }
    
    private func setUpLabelLayout() {
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: JesflixSize.marginXS.rawValue).isActive = true
    }
}
