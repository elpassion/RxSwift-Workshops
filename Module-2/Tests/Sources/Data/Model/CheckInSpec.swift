@testable import Workshops_Module2
import Nimble
import Quick

class CheckInSpec: QuickSpec {

    override func spec() {
        describe("CheckIn") {
            var sut: CheckIn!

            beforeEach {
                sut = CheckIn(username: "Kuba")
            }

            afterEach {
                sut = nil
            }

            context("when serialized") {
                var serialized: [String: String]?

                beforeEach {
                    serialized = JSONEncoder().serialized(sut) as? [String: String]
                }

                afterEach {
                    serialized = nil
                }

                it("should be serialized correctly") {
                    expect(serialized) == ["username": "Kuba"]
                }
            }
        }
    }

}
