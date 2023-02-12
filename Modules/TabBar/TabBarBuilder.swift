import UIKit

class TabBarBuilder {
    private var tabs: [UINavigationController]
    
    init(tabs: [UINavigationController]) {
        self.tabs = tabs
    }
    
    func build() -> UIViewController {
        let presenter = TabBarPresenter()
        let view = TabBarViewController(tabs: tabs, presenter: presenter)
        presenter.view = view
        return view
    }
}
