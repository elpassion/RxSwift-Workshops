@testable import Workshops_Module2
import Nimble
import Quick

class WindowFactorySpec: QuickSpec {

    override func spec() {
        describe("WindowFactory") {
            var sut: WindowFactory!

            beforeEach {
                sut = WindowFactory(screenBounds: CGRect(x: 10.0, y: 10.0, width: 100.0, height: 100.0))
            }

            afterEach {
                sut = nil
            }

            it("should conform to WindowFactoryProtocol") {
                expect(sut).to(beAKindOf(WindowFactoryProtocol.self))
            }

            context("when creating window") {
                var window: UIWindow!
                var rootViewController: UIViewController!

                beforeEach {
                    rootViewController = UIViewController(nibName: nil, bundle: nil)
                    window = sut.makeKeyWindow(rootViewController: rootViewController)
                }

                afterEach {
                    window = nil
                    rootViewController = nil
                }

                it("should NOT be nil") {
                    expect(window).notTo(beNil())
                }

                it("should have correct frame") {
                    expect(window.frame) == CGRect(x: 10.0, y: 10.0, width: 100.0, height: 100.0)
                }

                it("should set root view controller") {
                    expect(window.rootViewController) === rootViewController
                }

                it("should be key window") {
                    expect(window.isKeyWindow) == true
                }
            }
        }
    }

}
