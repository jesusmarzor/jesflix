import UIKit

protocol CollectionViewMoviesCellProtocol: AnyObject {
    func goToEntertainmentDetail(entertainment: EntertainmentProtocol)
}

class CollectionViewMoviesCell: UITableViewCell {
    static let identifier = "CollectionViewMoviesCell"
    weak var delegate: CollectionViewMoviesCellProtocol?
    
    private var entertainments: [EntertainmentProtocol] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewMovieCell.self, forCellWithReuseIdentifier: CollectionViewMovieCell.identifier)
        collectionView.backgroundColor = UIColor.clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: JesflixSize.marginXS.rawValue, bottom: 0, right: JesflixSize.marginXS.rawValue)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    func configure(entertainments: [EntertainmentProtocol], delegate: CollectionViewMoviesCellProtocol) {
        self.delegate = delegate
        self.entertainments = entertainments
    }
}

extension CollectionViewMoviesCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewMovieCell.identifier, for: indexPath) as? CollectionViewMovieCell else { return UICollectionViewCell()}
        cell.configure(entertainment: entertainments[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entertainments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.goToEntertainmentDetail(entertainment: entertainments[indexPath.row])
    }
}
