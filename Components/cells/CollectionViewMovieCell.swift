import UIKit

class CollectionViewMovieCell: UICollectionViewCell {
    static let identifier = "CollectionViewMovieCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var voteAverageBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = JesflixHeightSize.S.rawValue / 2
        return view
    }()
    
    private lazy var voteAverageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.theme(.bold18)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configure(entertainment: EntertainmentProtocol) {
        imageView.load_sdImage(with: entertainment.imageURL())
        voteAverageLabel.text = String(describing: entertainment.voteAverage ?? 0)
        if let vote = entertainment.voteAverage, vote > 5 {
            if vote >= 8 {
                voteAverageBackground.backgroundColor = UIColor.systemGreen
            } else {
                voteAverageBackground.backgroundColor = UIColor.orange
            }
        } else {
            voteAverageBackground.backgroundColor = UIColor.red
        }
    }
    
    private func commonInit() {
        layer.cornerRadius = 10
        setUpImageViewLayout()
        setUpVoteAverageLayout()
    }
    
    private func setUpImageViewLayout() {
        addSubview(imageView)
        imageView.frame = bounds
    }
    
    private func setUpVoteAverageLayout() {
        addSubview(voteAverageBackground)
        voteAverageBackground.translatesAutoresizingMaskIntoConstraints = false
        voteAverageBackground.topAnchor.constraint(equalTo: topAnchor, constant: JesflixSize.marginXS.rawValue).isActive = true
        voteAverageBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -JesflixSize.marginXS.rawValue).isActive = true
        voteAverageBackground.heightAnchor.constraint(equalToConstant: JesflixHeightSize.S.rawValue).isActive = true
        voteAverageBackground.widthAnchor.constraint(equalToConstant: JesflixHeightSize.S.rawValue).isActive = true
        
        voteAverageBackground.addSubview(voteAverageLabel)
        voteAverageLabel.translatesAutoresizingMaskIntoConstraints = false
        voteAverageLabel.centerXAnchor.constraint(equalTo: voteAverageBackground.centerXAnchor).isActive = true
        voteAverageLabel.centerYAnchor.constraint(equalTo: voteAverageBackground.centerYAnchor).isActive = true
    }
}
