import UIKit

protocol LoaderProtocol: AnyObject {
    func showLoader()
    func hideLoader()
}

extension UIViewController {
    func showLoader() {
        let spinnerView = UIView(frame: self.view.frame)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            self.view.addSubview(spinnerView)
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.view.subviews.last?.removeFromSuperview()
        }
    }
}