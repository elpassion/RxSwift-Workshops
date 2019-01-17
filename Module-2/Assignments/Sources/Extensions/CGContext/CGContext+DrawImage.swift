import UIKit

extension CGContext {

    static func drawImage(of size: CGSize, using drawingMethod: (CGContext) -> Void) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

        defer {
            UIGraphicsEndImageContext()
        }

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        drawingMethod(context)

        return UIGraphicsGetImageFromCurrentImageContext()
    }

}
