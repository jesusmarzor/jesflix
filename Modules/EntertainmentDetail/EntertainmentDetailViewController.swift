import UIKit

class EntertainmentDetailViewController: UIViewController {
    private let presenter: EntertainmentDetailPresenterProtocol
    private let entertainment: EntertainmentProtocol
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = UIColor.theme(.black)
        button.addTarget(self, action: #selector(didTapCloseButton), for: .touchDown)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = entertainment.title
        label.font = UIFont.theme(.bold22)
        label.textColor = UIColor.theme(.black)
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.text = entertainment.overview
        label.numberOfLines = 0
        label.font = UIFont.theme(.regular16)
        label.textColor = UIColor.theme(.black)
        return label
    }()
    
    init (entertainment: EntertainmentProtocol, presenter: EntertainmentDetailPresenterProtocol) {
        self.presenter = presenter
        self.entertainment = entertainment
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.theme(.white)
        navigationItem.leftBarButtonItem?.isHidden = false
        navigationController?.navigationBar.tintColor = UIColor.theme(.black)
        setUpCloseButton()
        setUpTitleLabelLayout()
        setUpOverviewLabelLayout()
    }
    
    private func setUpCloseButton() {
        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: JesflixSize.marginS.rawValue).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -JesflixSize.marginS.rawValue).isActive = true
        view.bringSubviewToFront(closeButton)
    }
    
    private func setUpTitleLabelLayout() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: JesflixSize.marginS.rawValue).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: JesflixSize.marginS.rawValue).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -JesflixSize.marginS.rawValue).isActive = true
    }
    
    private func setUpOverviewLabelLayout() {
        view.addSubview(overviewLabel)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: JesflixSize.marginM.rawValue).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: JesflixSize.marginS.rawValue).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -JesflixSize.marginS.rawValue).isActive = true
    }
    
    @objc
    private func didTapCloseButton() {
        dismiss(animated: true)
    }
}

extension EntertainmentDetailViewController: EntertainmentDetailViewProtocol {
}
