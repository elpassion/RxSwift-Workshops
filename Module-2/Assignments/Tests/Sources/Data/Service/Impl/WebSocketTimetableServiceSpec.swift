@testable import Workshops_Module2
import Nimble
import Quick
import RxSwift

class WebSocketTimetableServiceSpec: QuickSpec {

    override func spec() {
        describe("WebSocketTimetableService") {
            var socketURL: URL?
            var socketSpy: WebSocketSpy!
            var sut: WebSocketTimetableService!

            beforeEach {
                socketSpy = WebSocketSpy(url: URL(fileURLWithPath: ""))

                sut = WebSocketTimetableService(webSocketFactory: { url in
                    socketURL = url
                    return socketSpy
                })
            }

            afterEach {
                socketURL = nil
                socketSpy = nil
                sut = nil
            }

            context("when fetching timetable entries") {
                var entries: [TimetableEntry]!
                var disposeBag: DisposeBag!

                beforeEach {
                    disposeBag = DisposeBag()

                    sut.timetableEntries
                        .subscribe(onNext: { entries = $0 })
                        .disposed(by: disposeBag)

                    let timetablesText = String(data: Bundle.jsonData(forName: "timetables_ws"), encoding: .utf8)!
                    socketSpy.onText?(timetablesText)
                }

                afterEach {
                    disposeBag = nil
                    entries = nil
                }

                it("should create webservice passing proper URL") {
                    expect(socketURL?.absoluteString) == "ws://peaceful-fortress-94735.herokuapp.com/timetables/"
                }

                it("should connect to the webservice") {
                    expect(socketSpy.didConnect) == true
                }

                it("should return correct entries") {
                    expect(entries).toEventually(haveCount(3))
                    expect(entries[0].id) == 2
                    expect(entries[1].id) == 3
                    expect(entries[2].id) == 4
                }

                context("when binding is disposed") {
                    beforeEach {
                        disposeBag = nil
                    }

                    it("should disconnect from the webservice") {
                        expect(socketSpy.didDisconnect).toEventually(beTrue())
                    }
                }
            }
        }
    }

}
