import UIKit

class FavouritesViewController: UIViewController {
    private let presenter: FavouritesPresenterProtocol
        
    init (presenter: FavouritesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
    }
}

extension FavouritesViewController: FavouritesViewProtocol {
}
