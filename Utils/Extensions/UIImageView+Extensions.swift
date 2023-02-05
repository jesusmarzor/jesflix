import UIKit
import SDWebImage

extension UIImageView {
    func load_sdImage(with urlStr: String?, placeholder: UIImage? = nil) {
        guard let urlStr = urlStr, !urlStr.isEmpty else {
            self.image = placeholder
            return
        }

        if urlStr.contains("https") || urlStr.contains("http") {
            self.image = nil
            self.sd_setImage(with: URL(string: urlStr), placeholderImage: placeholder, options: .delayPlaceholder)
        } else {
            self.image = UIImage(named: urlStr)
        }
    }
}
