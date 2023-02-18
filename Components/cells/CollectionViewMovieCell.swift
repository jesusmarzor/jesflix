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
    }
    
    private func commonInit() {
        layer.cornerRadius = 10
        setUpImageViewLayout()
    }
    
    private func setUpImageViewLayout() {
        addSubview(imageView)
        imageView.frame = bounds
    }
}
