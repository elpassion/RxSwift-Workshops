@testable import Workshops_Module2
import Nimble
import Quick

class LocalFileTimetableServiceSpec: QuickSpec {

    override func spec() {
        describe("LocalFileTimetableService") {
            var sut: LocalFileTimetableService!

            beforeEach {
                sut = LocalFileTimetableService()
            }

            afterEach {
                sut = nil
            }

            context("when fetching timetable entries") {
                var entries: [TimetableEntry]!

                beforeEach {
                    _ = sut.timetableEntries.subscribe(onNext: { entries = $0 })
                }

                afterEach {
                    entries = nil
                }

                it("should return entries from local file (example.json)") {
                    expect(entries).to(haveCount(9))
                    expect(entries.map { $0.id }) == [1, 2, 3, 4, 5, 6, 7, 8, 9]
                }
            }
        }
    }

}
