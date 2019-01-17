import UIKit

extension UISegmentedControl {

    func simulateTap(atIndex index: Int) {
        selectedSegmentIndex = index
        sendActions(for: .valueChanged)
    }

}
