import UIKit

class TabBarViewController: UITabBarController {
    private let presenter: TabBarPresenterProtocol
        
    init (presenter: TabBarPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UINavigationController(rootViewController: HomeBuilder() {_ in}.build())
        let vc2 = UINavigationController(rootViewController: LoginBuilder() {_ in}.build())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "profile")
        
        vc1.title = "home"
        vc2.title = "login"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2], animated: true)
    }
}

extension TabBarViewController: TabBarViewProtocol {
}
