@testable import Workshops_Module2
import RxCocoa
import RxSwift

class TimetableServiceStub: TimetableService {

    var stubbedTimetableEntries: PublishSubject<[TimetableEntry]> = PublishSubject()
    var stubbedError: Error?

    // MARK: - TimetableService

    var timetableEntries: Observable<[TimetableEntry]> {
        if let error = stubbedError {
            return .error(error)
        } else {
            return stubbedTimetableEntries.asObservable()
        }
    }

}
