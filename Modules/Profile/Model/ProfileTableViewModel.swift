import UIKit

struct ProfileTableViewModel {
    let type: ProfileTableViewModelType
    let icon: UIImage
    let label: String?
}

enum ProfileTableViewModelType {
    case header
    case editProfile
    case changePassword
    case logout
}
