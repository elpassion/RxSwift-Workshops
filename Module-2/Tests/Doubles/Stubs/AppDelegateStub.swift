@testable import Workshops_Module2
import UIKit

class AppDelegateStub: NSObject, UIApplicationDelegate {

    @objc var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()

        return true
    }

}
