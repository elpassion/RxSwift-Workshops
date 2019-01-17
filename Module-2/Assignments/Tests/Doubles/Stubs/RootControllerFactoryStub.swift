@testable import Workshops_Module2
import UIKit

class RootControllerFactoryStub: RootControllerFactoryProtocol {

    let stubbedRootController = UIViewController(nibName: nil, bundle: nil)

    // MARK: - RootControllerFactoryProtocol

    func makeRootController() -> UIViewController {
        return stubbedRootController
    }

}
