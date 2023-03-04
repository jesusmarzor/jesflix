import UIKit

class SearchViewController: UIViewController {
    private let presenter: SearchPresenterProtocol
        
    init (presenter: SearchPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
    }
}

extension SearchViewController: SearchViewProtocol {
}
