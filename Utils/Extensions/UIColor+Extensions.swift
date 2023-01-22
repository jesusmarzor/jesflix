import UIKit

extension UIColor {
    static func getColor(color: JesflixColor) -> UIColor {
        return UIColor(named: color.rawValue) ?? UIColor.white
    }
}
