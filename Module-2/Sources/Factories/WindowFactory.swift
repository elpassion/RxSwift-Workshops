import UIKit

class WindowFactory: WindowFactoryProtocol {

    init(screenBounds: CGRect) {
        self.screenBounds = screenBounds
    }

    // MARK: - WindowFactoryProtocol

    func makeKeyWindow(rootViewController: UIViewController) -> UIWindow {
        let window = UIWindow(frame: screenBounds)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()

        return window
    }

    // MARK: - Privates

    private let screenBounds: CGRect

}
