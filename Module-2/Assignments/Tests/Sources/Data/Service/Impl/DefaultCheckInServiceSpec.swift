@testable import Workshops_Module2
import Nimble
import OHHTTPStubs
import Quick

class DefaultCheckInServiceSpec: QuickSpec {

    override func spec() {
        describe("DefaultCheckInService") {
            var sut: DefaultCheckInService!

            beforeEach {
                sut = DefaultCheckInService()
            }

            afterEach {
                sut = nil
            }

            context("when checking in") {
                var nextEmitted: Bool!
                var errorEmitted: Error?

                beforeEach {
                    nextEmitted = false
                }

                afterEach {
                    nextEmitted = nil
                    errorEmitted = nil
                    OHHTTPStubs.removeAllStubs()
                }

                context("with successful check-in (checkins array contains name)") {
                    beforeEach {
                        stub(condition: { request in
                            request.verify(method: "PUT",
                                           urlString: "http://peaceful-fortress-94735.herokuapp.com/api/v1/timetables/10/checkin/",
                                           body: try! JSONEncoder().encode(CheckIn(username: "Kuba")),
                                           headers: ["Content-Type": "application/json"])
                        }, response: { _ -> OHHTTPStubsResponse in
                            let response = Bundle.jsonData(forName: "checkin")
                            return OHHTTPStubsResponse(data: response, statusCode: 200, headers: [:])
                        })

                        _ = sut.checkIn(timetableID: 10, username: "Kuba").subscribe(onSuccess: {
                            nextEmitted = true
                        }, onError: {
                            errorEmitted = $0
                        })
                    }

                    it("should emit next event") {
                        expect(nextEmitted).toEventually(beTrue())
                    }
                }

                context("with unsuccessful check-in (checkins array does not contain name)") {
                    beforeEach {
                        stub(condition: { request in
                            request.verify(method: "PUT",
                                           urlString: "http://peaceful-fortress-94735.herokuapp.com/api/v1/timetables/19/checkin/",
                                           body: try! JSONEncoder().encode(CheckIn(username: "Janusz")),
                                           headers: ["Content-Type": "application/json"])
                        }, response: { _ -> OHHTTPStubsResponse in
                            let response = Bundle.jsonData(forName: "checkin")
                            return OHHTTPStubsResponse(data: response, statusCode: 200, headers: [:])
                        })

                        _ = sut.checkIn(timetableID: 19, username: "Janusz").subscribe(onSuccess: {
                            nextEmitted = true
                        }, onError: {
                            errorEmitted = $0
                        })
                    }

                    it("should emit not checked in error") {
                        expect(errorEmitted as? CheckInServiceError).toEventually(equal(CheckInServiceError.notCheckedIn))
                    }
                }
            }
        }
    }

}
