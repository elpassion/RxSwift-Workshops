import Quick
import Nimble
@testable import Workshops_Module2

class AppDelegateSpec: QuickSpec {

    override func spec() {
        describe("AppDelegate") {
            var sut: AppDelegate!
            var rootControllerFactoryStub: RootControllerFactoryStub!
            var windowFactorySpy: WindowFactorySpy!

            beforeEach {
                windowFactorySpy = WindowFactorySpy()
                rootControllerFactoryStub = RootControllerFactoryStub()
                sut = AppDelegate()
                sut.windowFactory = windowFactorySpy
                sut.rootControllerFactory = rootControllerFactoryStub
            }

            afterEach {
                sut = nil
                windowFactorySpy = nil
                rootControllerFactoryStub = nil
            }

            context("when application did finish launching") {
                var didFinishLaunching: Bool!

                beforeEach {
                    didFinishLaunching = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
                }

                it("should return true") {
                    expect(didFinishLaunching) == true
                }

                it("should set window from window factory") {
                    expect(sut.window) === windowFactorySpy.stubbedWindow
                }

                it("should pass correct view controller as a root") {
                    expect(windowFactorySpy.invokedKeyWindowWithController) === rootControllerFactoryStub.stubbedRootController
                }
            }
        }
    }

}
