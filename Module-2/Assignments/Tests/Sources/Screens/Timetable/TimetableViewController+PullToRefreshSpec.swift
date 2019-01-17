@testable import Workshops_Module2
import Nimble
import Quick
import RxSwift
import SVProgressHUD
import UIKit

class TimetableViewControllerSpec_PullToRefreshSpec: QuickSpec {

    override func spec() {
        describe("TimetableViewController+PullToRefresh") {
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

            context("when view is loaded") {
                var tableView: UITableView!

                beforeEach {
                    _ = sut.view
                    tableView = sut.timetableView.tableView
                }

                afterEach {
                    tableView = nil
                }

                context("when service returns correct data") {
                    beforeEach {
                        serviceStub.stubbedTimetableEntries.onNext(TimetableEntry.testEntries)
                        serviceStub.stubbedTimetableEntries.onCompleted()
                    }

                    it("should hide loading indicator") {
                        expect(progressHUDSpy) == [true, false]
                    }

                    it("should have refresh control set up") {
                        expect(sut.timetableView.tableView.refreshControl) === sut.refreshControl
                    }

                    it("should update table data source") {
                        expect(tableView.dataSource?.tableView(tableView, numberOfRowsInSection: 0)) == 5
                    }

                    it("should configure 1st cell properly") {
                        let cell = tableView.timetableCell(atRow: 0)

                        expect(cell?.nameLabel.text) == "EIP 1"
                        expect(cell?.timeLabel.text) == "14:00"
                    }

                    context("when pull to refresh is invoked") {
                        beforeEach {
                            serviceStub.stubbedTimetableEntries = PublishSubject()
                            let entries = Array(TimetableEntry.testEntries.suffix(from: 1))

                            sut.refreshControl.simulateRefresh()
                            serviceStub.stubbedTimetableEntries.onNext(entries)
                            serviceStub.stubbedTimetableEntries.onCompleted()
                        }

                        it("should show & hide loading indicator again") {
                            expect(progressHUDSpy) == [true, false, true, false]
                        }

                        it("should end refreshing") {
                            expect(sut.refreshControl.isRefreshing) == false
                        }

                        it("should update table data source") {
                            expect(tableView.dataSource?.tableView(tableView, numberOfRowsInSection: 0)) == 4
                        }

                        it("should configure 1st cell properly") {
                            let cell = tableView.timetableCell(atRow: 0)

                            expect(cell?.nameLabel.text) == "EIP 4"
                            expect(cell?.timeLabel.text) == "16:37"
                        }
                    }
                }
            }
        }
    }

}

private extension UITableView {

    func timetableCell(atRow row: Int) -> TimetableEntryCell? {
        let cell = dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
        return cell as? TimetableEntryCell
    }

}
