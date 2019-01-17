@testable import Workshops_Module2
import RxSwift
import RxTest

class CheckInServiceSpy: CheckInService {

    private(set) var checkInInvoked: (timetableID: Int, username: String)?
    var stubbedError: Error?

    init(_ testScheduler: TestScheduler, whenNextEvent: Int) {
        self.testScheduler = testScheduler
        self.whenNextEvent = whenNextEvent
    }

    // MARK: - CheckInService

    func checkIn(timetableID: Int, username: String) -> Single<Void> {
        checkInInvoked = (timetableID: timetableID, username: username)

        var events: [Recorded<Event<Void>>] = []

        if let receivedError = stubbedError {
            events.append(Recorded.error(whenNextEvent, receivedError))
        } else {
            events.append(Recorded.next(whenNextEvent, ()))
            events.append(Recorded.completed(whenNextEvent))
        }

        return testScheduler.createColdObservable(events).asSingle()
    }

    // MARK: - Private

    private let testScheduler: TestScheduler
    private let whenNextEvent: Int

}
