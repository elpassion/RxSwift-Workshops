import UIKit

extension UIImage {

    static func with(color: UIColor) -> UIImage? {
        let imageRectangle = CGRect(x: 0, y: 0, width: 1, height: 1)

        return CGContext.drawImage(of: imageRectangle.size) { context in
            context.setFillColor(color.cgColor)
            context.fill(imageRectangle)
        }
    }

}
