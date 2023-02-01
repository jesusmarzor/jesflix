import UIKit

extension String {
    static func getLabelForKey(_ key: String) -> String {
        return NSLocalizedString(key, comment: key)
    }
    
    static func getLabelForError(_ error: JesflixError) -> String {
        switch error {
        case .wrongPassword:
            return String.getLabelForKey("error_wrong_password")
            
        case .common:
            return String.getLabelForKey("error_common")
        }
    }
}
