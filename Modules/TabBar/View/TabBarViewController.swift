import UIKit

class TabBarViewController: UITabBarController {
    private let presenter: TabBarPresenterProtocol
    private let tabs: [UINavigationController]
    
    init (tabs: [UINavigationController], presenter: TabBarPresenterProtocol) {
        self.presenter = presenter
        self.tabs = tabs
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.standardAppearance = tabBarAppearance
        tabBar.tintColor = .label
        setViewControllers(tabs, animated: true)
    }
    
    var tabBarAppearance: UITabBarAppearance {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor.theme(.white)
        appearance.shadowColor = nil
        appearance.shadowImage = nil
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.theme(.black),
                                                                         NSAttributedString.Key.font: UIFont.theme(.regular10)]
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.theme(.black)
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.theme(.gray)
        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.theme(.gray),
                                                                           NSAttributedString.Key.font: UIFont.theme(.regular10)]
        return appearance
    }
}

extension TabBarViewController: TabBarViewProtocol {
}
