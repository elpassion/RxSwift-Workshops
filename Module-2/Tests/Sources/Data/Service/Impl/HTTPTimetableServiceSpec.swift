@testable import Workshops_Module2
import Nimble
import OHHTTPStubs
import Quick

class HTTPTimetableServiceSpec: QuickSpec {

    override func spec() {
        describe("HTTPTimetableService") {
            var sut: HTTPTimetableService!

            beforeEach {
                sut = HTTPTimetableService()
            }

            afterEach {
                OHHTTPStubs.removeAllStubs()
                sut = nil
            }

            context("when fetching timetable entries") {
                context("with 200 OK response with expected body") {
                    var entries: [TimetableEntry]!

                    beforeEach {
                        stub(condition: { request in
                            request.verify(method: "GET",
                                           urlString: "http://peaceful-fortress-94735.herokuapp.com/api/v1/timetables/",
                                           body: nil,
                                           headers: ["Content-Type": "application/json"])
                        }, response: { _ -> OHHTTPStubsResponse in
                            let data = Bundle.jsonData(forName: "timetables")
                            return OHHTTPStubsResponse(data: data, statusCode: 200, headers: [:])
                        })

                        _ = sut.timetableEntries.subscribe(onNext: { entries = $0 })
                    }

                    afterEach {
                        entries = nil
                    }

                    it("should return correct entries") {
                        expect(entries).toEventually(haveCount(3))
                        expect(entries[0].id) == 2
                        expect(entries[1].id) == 3
                        expect(entries[2].id) == 4
                    }
                }

                context("with 404 response with expected body") {
                    var error: Error?

                    beforeEach {
                        stub(condition: { request in
                            request.verify(method: "GET",
                                           urlString: "http://peaceful-fortress-94735.herokuapp.com/api/v1/timetables/",
                                           body: nil,
                                           headers: ["Content-Type": "application/json"])
                        }, response: { _ -> OHHTTPStubsResponse in
                            let data = Bundle.jsonData(forName: "timetables")
                            return OHHTTPStubsResponse(data: data, statusCode: 404, headers: [:])
                        })

                        _ = sut.timetableEntries.subscribe(onError: { error = $0 })
                    }

                    afterEach {
                        error = nil
                    }

                    it("should return unknown error") {
                        expect(error).toEventually(matchError(TimetableServiceError.unknown))
                    }
                }
            }
        }
    }

}
