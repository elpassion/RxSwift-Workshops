@testable import Workshops_Module2
import Nimble
import Quick
import SVProgressHUD
import UIKit

class TimetableViewControllerSpec_ActivityIndicatorSpec: QuickSpec {

    override func spec() {
        describe("TimetableViewController+ActivityIndicator") {
            var progressHUDSpy: [Bool]!
            var serviceStub: TimetableServiceStub!
            var filterSpy: TimetableFilterSpy!
            var sut: TimetableViewController!

            beforeEach {
                progressHUDSpy = []
                serviceStub = TimetableServiceStub()
                filterSpy = TimetableFilterSpy()
                sut = TimetableViewController(
                    timetableService: serviceStub,
                    presenter: TimeTableCellPresenter.testInstance,
                    filter: filterSpy
                )

                SVProgressHUD_show = { progressHUDSpy.append(true) }
                SVProgressHUD_dismiss = { progressHUDSpy.append(false) }
            }

            afterEach {
                progressHUDSpy = nil
                serviceStub = nil
                filterSpy = nil
                sut = nil

                SVProgressHUD_dismiss = SVProgressHUD.dismiss
                SVProgressHUD_show = SVProgressHUD.show
            }

            it("should NOT show loading indicator yet") {
                expect(progressHUDSpy) == []
            }

            context("when view is loaded") {
                beforeEach {
                    _ = sut.view
                }

                it("should show loading indicator") {
                    expect(progressHUDSpy) == [true]
                }

                context("when service returns correct data") {
                    beforeEach {
                        serviceStub.stubbedTimetableEntries.onNext(TimetableEntry.testEntries)
                        serviceStub.stubbedTimetableEntries.onCompleted()
                    }

                    it("should hide loading indicator") {
                        expect(progressHUDSpy) == [true, false]
                    }
                }
            }
        }
    }

}
