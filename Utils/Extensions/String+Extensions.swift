import UIKit

extension String {
    static func getLabelForKey(_ key: String) -> String {
        return NSLocalizedString(key, comment: key)
    }
}
