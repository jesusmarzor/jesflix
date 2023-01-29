import UIKit

class HomeViewController: UIViewController {
    private let presenter: HomePresenterProtocol
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = String.getLabelForKey("common_home")
        label.textColor = UIColor.theme(.redDark)
        label.font = UIFont.theme(.bold30)
        label.textAlignment = .center
        return label
    }()
    
    init (presenter: HomePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.view.backgroundColor = UIColor.theme(.white)
        setUpTitleLabel()
    }
    
    private func setUpTitleLabel() {
        self.view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
}

extension HomeViewController: HomeViewProtocol {
}
