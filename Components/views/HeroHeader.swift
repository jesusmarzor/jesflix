import UIKit

class HeroHeader: UIView {
    private lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        return gradient
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
        setUpHeroImageViewLayout()
        setUpGradientLayout()
    }
    
    func configure(entertainment: EntertainmentProtocol) {
        heroImageView.load_sdImage(with: entertainment.imageURL())
    }
    
    private func setUpGradientLayout() {
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.theme(.white).cgColor,
        ]
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        gradient.colors?[1] = UIColor.theme(.white).cgColor
        self.setNeedsDisplay()
    }
    
    private func setUpHeroImageViewLayout() {
        addSubview(heroImageView)
        heroImageView.frame = bounds 
    }
}
