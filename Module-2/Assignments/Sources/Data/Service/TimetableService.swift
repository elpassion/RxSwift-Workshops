import RxSwift

protocol TimetableService {
    var timetableEntries: Observable<[TimetableEntry]> { get }
}
