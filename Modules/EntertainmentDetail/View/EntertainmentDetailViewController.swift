import youtube_ios_player_helper

class EntertainmentDetailViewController: UIViewController {
    private let presenter: EntertainmentDetailPresenterProtocol
    private let entertainment: EntertainmentProtocol
    private var viewTranslation = CGPoint(x: 0, y: 0)
    private let playerView: YTPlayerView
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.backgroundColor = UIColor.theme(.body)
        table.register(PlayerDescriptionCell.self, forCellReuseIdentifier: PlayerDescriptionCell.identifier)
        table.separatorStyle = .none
        return table
    }()
    
    init (entertainment: EntertainmentProtocol, presenter: EntertainmentDetailPresenterProtocol) {
        self.presenter = presenter
        self.entertainment = entertainment
        self.playerView = YTPlayerView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(entertainment: entertainment)
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
        view.backgroundColor = UIColor.theme(.body)
        playerView.delegate = self
        setUpPlayerViewLayout()
        tableView.delegate = self
        tableView.dataSource = self
        setUpTableViewLayout()
    }
    
    private func setUpPlayerViewLayout() {
        view.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        playerView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3 / 4).isActive = true
    }
    
    private func setUpTableViewLayout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: playerView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    @objc
    func handleDismiss(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            viewTranslation = sender.translation(in: view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
            })
            
        case .ended:
            if viewTranslation.y < 200 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.view.transform = .identity
                })
            } else {
                dismiss(animated: true, completion: nil)
            }
            
        default:
            break
        }
    }
}

extension EntertainmentDetailViewController: EntertainmentDetailViewProtocol {
    func updateYTPlayerVideo(with idVideo: String) {
        playerView.load(withVideoId: idVideo, playerVars: ["playsinline": 1, "controls": 0, "autohide": 1, "showinfo": 0, "rel": 0, "loop": 1, "modestbranding": 1])
    }
}

extension EntertainmentDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayerDescriptionCell.identifier, for: indexPath) as? PlayerDescriptionCell else {return UITableViewCell()}
        cell.backgroundColor = UIColor.theme(.body)
        cell.configure(title: entertainment.title, overview: entertainment.overview, popularity: entertainment.popularity ?? 0)
        return cell
    }
}

extension EntertainmentDetailViewController: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
