@testable import Workshops_Module2
import Nimble
import Quick
import UIKit

class TimetableViewControllerSpec: QuickSpec {

    override func spec() {
        describe("TimetableViewController") {
            var serviceStub: TimetableServiceStub!
            var filterSpy: TimetableFilterSpy!
            var sut: TimetableViewController!

            beforeEach {
                serviceStub = TimetableServiceStub()
                filterSpy = TimetableFilterSpy()
                sut = TimetableViewController(
                    timetableService: serviceStub,
                    presenter: TimeTableCellPresenter.testInstance,
                    filter: filterSpy
                )
            }

            afterEach {
                serviceStub = nil
                filterSpy = nil
                sut = nil
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
                    }

                    it("should have refresh control set up") {
                        expect(sut.timetableView.tableView.refreshControl) === sut.refreshControl
                    }

                    it("should have 1st segment selected") {
                        expect(sut.timetableView.filterView.segmentedControl.selectedSegmentIndex) == 0
                    }

                    it("should have correct filter entries") {
                        let segmentedControl = sut.timetableView.filterView.segmentedControl

                        expect(segmentedControl.numberOfSegments) == 4
                        expect(segmentedControl.titleForSegment(at: 0)) == "All"
                        expect(segmentedControl.titleForSegment(at: 1)) == "<30 min"
                        expect(segmentedControl.titleForSegment(at: 2)) == "30-60 min"
                        expect(segmentedControl.titleForSegment(at: 3)) == ">60 min"
                    }

                    it("should apply the filter to items") {
                        expect(filterSpy.applyInvoked?.filter) == Filter.all
                        expect(filterSpy.applyInvoked?.timetableEntries).to(haveCount(5))
                        expect(filterSpy.filteredEntries).to(haveCount(5))
                        expect(filterSpy.filteredEntries?.map { $0.id }).to(contain([1, 2, 3, 4, 5]))
                    }

                    it("should update table data source") {
                        expect(tableView.dataSource?.tableView(tableView, numberOfRowsInSection: 0)) == 5
                    }

                    it("should configure 2nd cell properly") {
                        let cell = tableView.timetableCell(atRow: 1)

                        expect(cell?.nameLabel.text) == "EIP 4"
                        expect(cell?.timeLabel.text) == "16:37"
                    }

                    it("should configure last cell properly") {
                        let cell = tableView.timetableCell(atRow: 4)

                        expect(cell?.nameLabel.text) == "EIP 2"
                        expect(cell?.timeLabel.text) == "15:00"
                    }

                    it("should contain sorted rows") {
                        let rows = tableView.numberOfRows(inSection: 0)
                        let names: [String] = (0..<rows).compactMap { tableView.timetableCell(atRow: $0)?.nameLabel.text }

                        expect(names) == ["EIP 1", "EIP 4", "EIP 3", "EIP 5", "EIP 2"]
                    }

                    context("when tap on 3rd segment") {
                        beforeEach {
                            serviceStub.stubbedTimetableEntries.onNext(TimetableEntry.testEntries)
                            sut.timetableView.filterView.segmentedControl.simulateTap(atIndex: 2)
                        }

                        it("should apply the filter to items") {
                            expect(filterSpy.applyInvoked?.filter) == Filter.thirtyToSixtyMinutes
                            expect(filterSpy.applyInvoked?.timetableEntries).to(haveCount(5))
                            expect(filterSpy.filteredEntries).to(haveCount(3))
                            expect(filterSpy.filteredEntries?.map { $0.id }).to(contain([1, 3, 5]))
                        }

                        it("should have 3rd segment selected") {
                            expect(sut.timetableView.filterView.segmentedControl.selectedSegmentIndex) == 2
                        }

                        it("should contain sorted rows") {
                            let rows = tableView.numberOfRows(inSection: 0)
                            let names: [String] = (0..<rows).compactMap { tableView.timetableCell(atRow: $0)?.nameLabel.text }

                            expect(names) == ["EIP 1", "EIP 3", "EIP 5"]
                        }
                    }

                    context("when presenting details controller") {
                        var invokedPush: [(viewController: UIViewController, animated: Bool)]!

                        beforeEach {
                            invokedPush = []

                            sut.pushController = { controller, animated in
                                invokedPush.append((viewController: controller, animated: animated))
                            }
                        }

                        afterEach {
                            invokedPush = nil
                        }

                        context("when check-in is tapped") {

                            context("with non-reused cell") {
                                beforeEach {
                                    let cell = tableView.timetableCell(atRow: 1)

                                    cell?.checkInButton.simulateTap()
                                }

                                it("should trigger push only once") {
                                    expect(invokedPush.count) == 1
                                }

                                it("should trigger push with correct parameters") {
                                    expect(invokedPush.first?.viewController).to(beAKindOf(CheckInViewController.self))
                                    expect(invokedPush.first?.animated) == true
                                }

                                it("should pass correct check-in identifier") {
                                    let checkInController = invokedPush.first?.viewController as? CheckInViewController

                                    expect(checkInController?.timetableID) == 4
                                }
                            }

                            context("with reused cell") {
                                beforeEach {
                                    let cell = tableView.timetableCell(atRow: 1)!

                                    tableView.delegate?.tableView?(tableView, didEndDisplaying: cell, forRowAt: IndexPath(row: 1, section: 0))
                                    cell.prepareForReuse()

                                    cell.checkInButton.simulateTap()
                                }

                                it("should NOT trigger push") {
                                    expect(invokedPush.count) == 0
                                }
                            }
                        }
                    }
                }
            }

            context("when service throws an error") {
                context("when view is loaded") {
                    beforeEach {
                        _ = sut.view

                        serviceStub.stubbedTimetableEntries.onNext(TimetableEntry.testEntries)
                        serviceStub.stubbedTimetableEntries.onError(TimetableServiceError.unknown)
                    }

                    it("should NOT show any rows") {
                        expect(sut.timetableView.tableView.dataSource?.tableView(sut.timetableView.tableView, numberOfRowsInSection: 0)) == 0
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
