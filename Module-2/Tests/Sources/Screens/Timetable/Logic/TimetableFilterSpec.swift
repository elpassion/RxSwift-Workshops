@testable import Workshops_Module2
import Nimble
import Quick

class TimetableFilterSpec: QuickSpec {

    override func spec() {
        describe("TimetableFilter") {
            var sut: TimetableFilter!

            beforeEach {
                sut = TimetableFilter(currentDateProvider: {
                    "2017-12-27 16:12:00".date()
                })
            }

            afterEach {
                sut = nil
            }

            context("when filtering items") {
                var filteredItems: [TimetableEntry]!

                afterEach {
                    filteredItems = nil
                }

                context("with .all filter") {
                    beforeEach {
                        filteredItems = sut.apply(filter: .all, for: TimetableEntry.testEntries)
                    }

                    it("should return future items") {
                        expect(filteredItems).to(haveCount(4))
                        expect(filteredItems[0].id) == 2
                        expect(filteredItems[1].id) == 3
                        expect(filteredItems[2].id) == 4
                        expect(filteredItems[3].id) == 5
                    }
                }

                context("with .underThirtyMinutes filter") {
                    beforeEach {
                        filteredItems = sut.apply(filter: .underThirtyMinutes, for: TimetableEntry.testEntries)
                    }

                    it("should return items which are under thirty minutes") {
                        expect(filteredItems).to(haveCount(1))
                        expect(filteredItems[0].id) == 4
                    }
                }

                context("with .thirtyToSixtyMinutes filter") {
                    beforeEach {
                        filteredItems = sut.apply(filter: .thirtyToSixtyMinutes, for: TimetableEntry.testEntries)
                    }

                    it("should return items which are over or exactly 30 minutes and below or exactly 60 minutes") {
                        expect(filteredItems).to(haveCount(2))
                        expect(filteredItems[0].id) == 3
                        expect(filteredItems[1].id) == 5
                    }
                }

                context("with .overSixtyMinutes filter") {
                    beforeEach {
                        filteredItems = sut.apply(filter: .overSixtyMinutes, for: TimetableEntry.testEntries)
                    }

                    it("should return items which are over 60 minutes") {
                        expect(filteredItems).to(haveCount(1))
                        expect(filteredItems[0].id) == 2
                    }
                }
            }
        }
    }

}
