import UIKit

class PlayerDescriptionCell: UITableViewCell {
    static let identifier = "PlayerDescriptionCell"
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.theme(.bold22)
        label.numberOfLines = 0
        return label
    }()
    
    private var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.theme(.regular16)
        label.numberOfLines = 0
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
        setUpTitleLabelLayout()
        setUpOverviewLabelLayout()
    }
    
    func configure(title: String, overview: String) {
        titleLabel.text = title
        overviewLabel.text = overview
    }
    
    private func setUpTitleLabelLayout() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: JesflixSize.marginXS.rawValue).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: JesflixSize.marginS.rawValue).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -JesflixSize.marginS.rawValue).isActive = true
    }
    
    private func setUpOverviewLabelLayout() {
        addSubview(overviewLabel)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: JesflixSize.marginXS.rawValue).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: JesflixSize.marginS.rawValue).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -JesflixSize.marginS.rawValue).isActive = true
        overviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -JesflixSize.marginS.rawValue).isActive = true
    }
}
