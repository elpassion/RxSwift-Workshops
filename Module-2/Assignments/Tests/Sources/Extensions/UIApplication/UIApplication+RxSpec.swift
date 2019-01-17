import Nimble
import Quick
import RxSwift
import SVProgressHUD
@testable import Workshops_Module2

class UIApplication_RxSpec: QuickSpec {
    override func spec() {
        describe("UIApplication+Rx") {
            var showCallCount: Int = 0
            var hideCallCount: Int = 0

            beforeEach {
                showCallCount = 0
                hideCallCount = 0

                SVProgressHUD_show = { showCallCount += 1 }
                SVProgressHUD_dismiss = { hideCallCount += 1 }
            }

            afterEach {
                SVProgressHUD_show = SVProgressHUD.show
                SVProgressHUD_dismiss = SVProgressHUD.dismiss
            }

            describe("progress") {
                var progress: PublishSubject<Bool>!

                beforeEach {
                    progress = PublishSubject()

                    _ = progress
                        .asDriver(onErrorJustReturn: false)
                        .drive(UIApplication.shared.rx.progress)
                }

                afterEach {
                    progress = nil
                }

                context("when true is emitted") {
                    beforeEach {
                        progress.onNext(true)
                        progress.onNext(true)
                    }

                    it("should call show method") {
                        expect(showCallCount) == 2
                    }
                }

                context("when false is emitted") {
                    beforeEach {
                        progress.onNext(false)
                        progress.onNext(false)
                        progress.onNext(false)
                    }

                    it("should call hide method") {
                        expect(hideCallCount) == 3
                    }
                }
            }
        }
    }
}
