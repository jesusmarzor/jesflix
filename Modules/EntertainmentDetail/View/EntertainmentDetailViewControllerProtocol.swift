import UIKit

protocol EntertainmentDetailViewProtocol: LoaderProtocol, HandleErrorProtocol {
    func updateYTPlayerVideo(with idVideo: String)
}
