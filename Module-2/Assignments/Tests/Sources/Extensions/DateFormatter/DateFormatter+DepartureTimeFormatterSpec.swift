import Nimble
import Quick
@testable import Workshops_Module2

class DateFormatter_DepartureTimeFormatterSpec: QuickSpec {
    override func spec() {
        describe("DateFormatter+DepartureTimeFormatter") {
            var sut: DateFormatter!

            beforeEach {
                sut = .departureTimeFormatter
            }

            afterEach {
                sut = nil
            }

            describe("formatted date") {
                var formatted: String!

                beforeEach {
                    let date = Date(timeIntervalSince1970: 1549547690)
                    formatted = sut.string(from: date)
                }

                afterEach {
                    formatted = nil
                }

                it("should be formatted in polish locale") {
                    expect(formatted) == "14:54"
                }
            }
        }
    }
}
