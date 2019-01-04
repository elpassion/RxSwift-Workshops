@testable import Workshops_Module2
import Nimble
import Quick

class RootControllerFactorySpec: QuickSpec {

    override func spec() {
        describe("RootControllerFactory") {
            var sut: RootControllerFactory!

            beforeEach {
                sut = RootControllerFactory()
            }

            afterEach {
                sut = nil
            }

            it("should conform to RootControllerFactoryProtocol") {
                expect(sut).to(beAKindOf(RootControllerFactoryProtocol.self))
            }

            context("when creating root controller") {
                it("should NOT throw assertion when creates root controller") {
                    var controller: UIViewController?

                    expect { controller = sut.makeRootController() }.toNot(throwAssertion())
                    expect(controller).to(beAnInstanceOf(UINavigationController.self))
                }

                it("should set TimetableViewController as root view controller") {
                    let rootController = sut.makeRootController() as? UINavigationController

                    expect(rootController?.children).to(haveCount(1))
                    expect(rootController?.viewControllers.first).to(beAnInstanceOf(TimetableViewController.self))
                }
            }
        }
    }

}
