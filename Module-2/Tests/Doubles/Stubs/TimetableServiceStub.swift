@testable import Workshops_Module2
import RxCocoa
import RxSwift

class TimetableServiceStub: TimetableService {

    var stubbedTimetableEntries: PublishSubject<[TimetableEntry]> = PublishSubject()

    // MARK: - TimetableService

    var timetableEntries: Observable<[TimetableEntry]> {
        return stubbedTimetableEntries.asObservable()
    }

}
