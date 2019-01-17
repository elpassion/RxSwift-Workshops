import UIKit

protocol WindowFactoryProtocol {
    func makeKeyWindow(rootViewController: UIViewController) -> UIWindow
}
