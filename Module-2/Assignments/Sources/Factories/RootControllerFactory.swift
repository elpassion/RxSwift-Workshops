import UIKit

class RootControllerFactory: RootControllerFactoryProtocol {

    // MARK: - RootControllerFactoryProtocol

    func makeRootController() -> UIViewController {
        return UINavigationController(rootViewController: TimetableViewController())
    }

}
