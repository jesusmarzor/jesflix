import UIKit

extension UIColor {
    static func theme(_ color: JesflixColor) -> UIColor {
        return UIColor(named: color.rawValue) ?? UIColor.white
    }
}
