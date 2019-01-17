import UIKit

extension UIControl {

    func simulateTap() {
        sendActions(for: .touchDown)
        sendActions(for: .touchUpInside)
    }

}
