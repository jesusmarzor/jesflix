import UIKit

class MovieDetail: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.theme(.bold22)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.theme(.regular16)
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
        setUpTitleLabelLayout()
    }
    
    func configure(movie: DtoMovie) {
        titleLabel.text = movie.title
    }
    
    private func setUpTitleLabelLayout() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: JesflixSize.marginL.rawValue).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: JesflixSize.marginS.rawValue).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -JesflixSize.marginS.rawValue).isActive = true
    }
    
    private func setUpSubtitleLabelLayout() {
        addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: JesflixSize.marginM.rawValue).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: JesflixSize.marginS.rawValue).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -JesflixSize.marginS.rawValue).isActive = true
    }
}

