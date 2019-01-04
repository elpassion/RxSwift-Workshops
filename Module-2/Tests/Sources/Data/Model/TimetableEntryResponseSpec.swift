@testable import Workshops_Module2
import Nimble
import Quick

class TimetableEntryResponseSpec: QuickSpec {

    override func spec() {
        describe("TimetableEntryResponse") {
            var sut: TimetableEntryResponse!

            afterEach {
                sut = nil
            }

            context("when deserialized from JSON") {
                beforeEach {
                    let data = Bundle.jsonData(forName: "timetables")
                    sut = try! JSONDecoder.default.decode(TimetableEntryResponse.self, from: data)
                }

                it("should return all entries") {
                    expect(sut.count) == 3
                }

                it("should deserialize next page correctly") {
                    expect(sut.nextPage) == 5
                }

                it("should deserialize previous page correctly") {
                    expect(sut.previousPage) == 3
                }

                it("should deserialize first entry correctly") {
                    let entry = sut.results.first

                    expect(entry?.id) == 2
                    expect(entry?.name) == "EIP 666"
                    expect(entry?.departureTime) == "2017-11-28 18:20:00".date()
                    expect(entry?.departsFrom) == "Warsaw Central Railway Station"
                    expect(entry?.arrivesTo) == "Sosnowiec Country Station"
                    expect(entry?.checkins) == ["Kuba", "Mateusz"]
                }
            }
        }
    }

}
