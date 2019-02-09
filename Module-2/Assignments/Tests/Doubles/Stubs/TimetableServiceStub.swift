@testable import Workshops_Module2
import RxCocoa
import RxSwift

class TimetableServiceStub: TimetableService {

    var stubbedTimetableEntries: PublishSubject<[TimetableEntry]> = PublishSubject()

    // MARK: - TimetableService

    var timetableEntries: Observable<[TimetableEntry]> {
        return Observable<[TimetableEntry]>.create { [unowned self] observer in
            self.stubbedTimetableEntries
                .subscribe { event in
                    observer.on(event)
                }
                .disposed(by: self.disposeBag)

            return Disposables.create()
        }
    }

    private let disposeBag = DisposeBag()

}
