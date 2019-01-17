@testable import Workshops_Module2
import UIKit

class WindowFactorySpy: WindowFactoryProtocol {

    var stubbedWindow = UIWindow(frame: .zero)
    private(set) var invokedKeyWindowWithController: UIViewController?

    // MARK: - WindowFactoryProtocol

    func makeKeyWindow(rootViewController: UIViewController) -> UIWindow {
        invokedKeyWindowWithController = rootViewController

        return stubbedWindow
    }

}
