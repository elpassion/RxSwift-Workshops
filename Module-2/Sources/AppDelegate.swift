import RxSwift
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    override init() {
        rootControllerFactory = RootControllerFactory()
    }

    var window: UIWindow?
    var rootControllerFactory: RootControllerFactoryProtocol
    lazy var windowFactory: WindowFactoryProtocol = WindowFactory(screenBounds: UIScreen.main.bounds)

    // MARK: - UIApplicationDelegate

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = windowFactory.makeKeyWindow(rootViewController: rootControllerFactory.makeRootController())

        return true
    }

}
