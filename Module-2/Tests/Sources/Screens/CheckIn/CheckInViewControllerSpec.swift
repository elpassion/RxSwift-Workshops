@testable import Workshops_Module2
import Nimble
import Quick
import RxSwift
import RxTest

class CheckInViewControllerSpec: QuickSpec {

    override func spec() {
        describe("CheckInViewController") {
            var testScheduler: TestScheduler!
            var checkInServiceSpy: CheckInServiceSpy!
            var sut: CheckInViewController!

            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                checkInServiceSpy = CheckInServiceSpy(testScheduler, whenNextEvent: 100)
                sut = CheckInViewController(timetableID: 19, checkInService: checkInServiceSpy)
            }

            afterEach {
                testScheduler = nil
                checkInServiceSpy = nil
                sut = nil
            }

            context("when view is loaded") {
                var observer: TestableObserver<Bool>!
                var invokedPopViewController: [Bool]!

                beforeEach {
                    invokedPopViewController = []

                    _ = sut.view

                    sut.popController = { animated in
                        invokedPopViewController.append(animated)
                        return nil
                    }
                }

                afterEach {
                    observer = nil
                    invokedPopViewController = nil
                }

                context("when check in service succeeds") {
                    beforeEach {
                        testScheduler.scheduleAt(0) {
                            sut.checkInView.nameTextField.text = "Test user"
                            sut.checkInView.nameTextField.sendActions(for: .valueChanged)
                        }

                        testScheduler.scheduleAt(20) {
                            sut.checkInView.checkInButton.simulateTap()
                        }

                        testScheduler.scheduleAt(75) {
                            sut.checkInView.checkInButton.simulateTap()
                        }

                        observer = testScheduler.start(created: 0, subscribed: 10, disposed: 300) {
                            sut.checkInComplete.asObservable().map { true }
                        }
                    }

                    it("should invoke check in service passing timetable ID and username") {
                        expect(checkInServiceSpy.checkInInvoked?.timetableID) == 19
                        expect(checkInServiceSpy.checkInInvoked?.username) == "Test user"
                    }

                    it("should emit exactly one next event when latest check in completes") {
                        XCTAssertEqual(observer.events, [
                            Recorded.next(175, true)
                        ])
                    }

                    it("should pop view controller only once") {
                        expect(invokedPopViewController.count) == 1
                    }

                    it("should pop view controller with animation") {
                        expect(invokedPopViewController.first) == true
                    }
                }

                context("when check in service fails") {
                    beforeEach {
                        testScheduler.scheduleAt(0) {
                            sut.checkInView.nameTextField.text = "John Doe"
                            sut.checkInView.nameTextField.sendActions(for: .valueChanged)
                        }

                        testScheduler.scheduleAt(30) {
                            sut.checkInView.checkInButton.simulateTap()
                        }

                        checkInServiceSpy.stubbedError = CheckInServiceError.notCheckedIn
                        observer = testScheduler.start(created: 0, subscribed: 10, disposed: 300) {
                            sut.checkInComplete.asObservable().map { true }
                        }
                    }

                    it("should invoke check in service passing timetable ID and username") {
                        expect(checkInServiceSpy.checkInInvoked?.timetableID) == 19
                        expect(checkInServiceSpy.checkInInvoked?.username) == "John Doe"
                    }

                    it("should NOT emit any events") {
                        expect(observer.events).to(haveCount(0))
                    }

                    it("should NOT pop view controller") {
                        expect(invokedPopViewController.count) == 0
                    }
                }
            }
        }
    }

}
