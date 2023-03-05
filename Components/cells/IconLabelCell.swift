import UIKit

class IconLabelCell: UITableViewCell {
    static let identifier = "IconLabelCell"
    
    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = UIColor.theme(.primary)
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.theme(.letter)
        label.font = UIFont.theme(.regular22)
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setUpIconViewLayout()
        setUpLabelLayout()
    }
    
    func configure(icon: UIImage, label: String) {
        iconView.image = icon
        self.label.text = label
    }
    
    private func setUpIconViewLayout() {
        self.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        iconView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: JesflixSize.marginM.rawValue).isActive = true
    }
    
    private func setUpLabelLayout() {
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: JesflixSize.marginS.rawValue).isActive = true
    }
}
