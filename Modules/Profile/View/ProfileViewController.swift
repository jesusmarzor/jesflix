import UIKit

class ProfileViewController: UIViewController {
    private let presenter: ProfilePresenterProtocol
    
    private var content: [ProfileTableViewModel] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(IconLabelCell.self, forCellReuseIdentifier: IconLabelCell.identifier)
        table.separatorStyle = .none
        table.backgroundColor = UIColor.clear
        return table
    }()
        
    init (presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        view.backgroundColor = UIColor.theme(.body)
        tableView.delegate = self
        tableView.dataSource = self
        setUpTableView()
    }
    
    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func updateContent(with content: [ProfileTableViewModel]) {
        self.content = content
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = content[indexPath.row]
        switch row.type {
        case .header:
            return UITableViewCell()
            
        case .editProfile, .changePassword, .logout:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IconLabelCell.identifier, for: indexPath) as? IconLabelCell else {return UITableViewCell()}
            cell.backgroundColor = UIColor.clear
            cell.configure(icon: row.icon, label: row.label!)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch content[indexPath.row].type {
        case .editProfile, .changePassword, .logout:
            return 60
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch content[indexPath.row].type {
        case .logout:
            presenter.logout()
            
        default:
            break
        }
    }
}
