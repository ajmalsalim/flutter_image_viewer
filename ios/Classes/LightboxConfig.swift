import UIKit
import AVKit
import AVFoundation

open class LightboxConfig {

  public typealias LoadImageCompletion = (_ error: NSError?, _ image: UIImage?) -> Void

    public static var hideStatusBar = true

    public static var loadImage: (_ imageView: UIImageView, _ URL: URL, _ completion: LoadImageCompletion?) -> Void = {
    imageView, URL, completion in
    let imageRequest: URLRequest = URLRequest(url: URL)

    NSURLConnection.sendAsynchronousRequest(imageRequest,
      queue: OperationQueue.main,
      completionHandler: { _, data, error in
        if let data = data, let image = UIImage(data: data) {
          imageView.image = image
        }

        completion?(error as NSError?, imageView.image)
    })
  }

    public static var handleVideo: (_ from: UIViewController, _ videoURL: URL) -> Void = { from, videoURL in
    let videoController = AVPlayerViewController()
    videoController.player = AVPlayer(url: videoURL)

    from.present(videoController, animated: true) {
      videoController.player?.play()
    }
  }

  public struct PageIndicator {
    public static var enabled = true
    public static var separatorColor = UIColor(hex: "3D4757")

    public static var textAttributes = [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
        NSAttributedString.Key.foregroundColor: UIColor(hex: "899AB8"),
        NSAttributedString.Key.paragraphStyle: {
        var style = NSMutableParagraphStyle()
        style.alignment = .center
        return style
        }()
    ]
  }

  public struct CloseButton {
    public static var enabled = true
    public static var size: CGSize?
    public static var text = NSLocalizedString("Close", comment: "")
    public static var image: UIImage?

    public static var textAttributes = [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.paragraphStyle: {
        var style = NSMutableParagraphStyle()
        style.alignment = .center
        return style
        }()
    ]
  }

  public struct DeleteButton {
    public static var enabled = false
    public static var size: CGSize?
    public static var text = NSLocalizedString("Delete", comment: "")
    public static var image: UIImage?

    public static var textAttributes = [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
        NSAttributedString.Key.foregroundColor: UIColor(hex: "FA2F5B"),
        NSAttributedString.Key.paragraphStyle: {
        var style = NSMutableParagraphStyle()
        style.alignment = .center
        return style
        }()
    ]
  }

  public struct InfoLabel {
    public static var enabled = true
    public static var textColor = UIColor.white
    public static var ellipsisText = NSLocalizedString("Show more", comment: "")
    public static var ellipsisColor = UIColor(hex: "899AB9")

    public static var textAttributes = [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
        NSAttributedString.Key.foregroundColor: UIColor(hex: "DBDBDB")
    ]
  }

  public struct Zoom {
    public static var minimumScale: CGFloat = 1.0
    public static var maximumScale: CGFloat = 3.0
  }

  public struct LoadingIndicator {
    public static var configure: ((UIActivityIndicatorView) -> Void)?
  }
}
