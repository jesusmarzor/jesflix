import UIKit

class HomeViewController: UIViewController {
    private let presenter: HomePresenterProtocol
    
    private var entertainmentSections: [DtoEntertainmentSection] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.reloadData()
            }
        }
    }
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewMoviesCell.self, forCellReuseIdentifier: CollectionViewMoviesCell.identifier)
        table.separatorStyle = .none
        table.backgroundColor = UIColor.clear
        table.contentInsetAdjustmentBehavior = .never
        return table
    }()
    
    private let heroHeader: HeroHeader = {
        let heroHeader = HeroHeader()
        return heroHeader
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
        view.backgroundColor = UIColor.theme(.body)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        presenter.viewDidLoad()
        setUpHomeFeedTableViewLayout()
    }
    
    private func setUpHomeFeedTableViewLayout() {
        view.addSubview(homeFeedTable)
        homeFeedTable.translatesAutoresizingMaskIntoConstraints = false
        homeFeedTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        homeFeedTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        homeFeedTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        homeFeedTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func loadHeroHeader() {
        if let popularMovie = entertainmentSections.first?.entertainments.last {
            let heroHeader = HeroHeader(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
            heroHeader.configure(entertainment: popularMovie)
            homeFeedTable.tableHeaderView = heroHeader
        }
    }
    
    private func reloadData() {
        loadHeroHeader()
        homeFeedTable.reloadData()
    }
}

extension HomeViewController: HomeViewProtocol {
    func updateEntertainmentSections(with entertainmentSection: DtoEntertainmentSection) {
        if let indexSection = entertainmentSections.firstIndex(where: {$0.type == entertainmentSection.type}) {
            entertainmentSections[indexSection] = entertainmentSection
        } else {
            entertainmentSections.append(entertainmentSection)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return entertainmentSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = entertainmentSections[indexPath.section]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewMoviesCell.identifier, for: indexPath) as? CollectionViewMoviesCell else {return UITableViewCell()}
        cell.backgroundColor = UIColor.clear
        cell.configure(entertainments: section.entertainments, delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        label.text = entertainmentSections[section].title
        label.font = UIFont.theme(.bold24)
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: JesflixSize.marginXS.rawValue).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -JesflixSize.marginXS.rawValue).isActive = true
        return view
    }
}

extension HomeViewController: CollectionViewMoviesCellProtocol {
    func goToEntertainmentDetail(entertainment: EntertainmentProtocol) {
        presenter.goToEntertainmentDetail(entertainment: entertainment)
    }
}
