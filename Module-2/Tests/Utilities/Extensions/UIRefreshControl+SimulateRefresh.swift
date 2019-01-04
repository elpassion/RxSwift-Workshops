import UIKit

extension UIRefreshControl {

    func simulateRefresh() {
        beginRefreshing()
        sendActions(for: .valueChanged)
    }

}
