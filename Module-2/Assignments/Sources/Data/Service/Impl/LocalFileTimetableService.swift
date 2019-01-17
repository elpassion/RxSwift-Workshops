import Foundation
import RxSwift

class LocalFileTimetableService: TimetableService {
    
    // MARK: - TimetableService

    var timetableEntries: Observable<[TimetableEntry]> {
        let timetables = Bundle.main
            .url(forResource: "Example", withExtension: "JSON")
            .flatMap { try? Data(contentsOf: $0) }
            .flatMap { try? JSONDecoder.default.decode(TimetableEntryResponse.self, from: $0) }

        guard let timetableEntries = timetables?.results else {
            return Observable.error(TimetableServiceError.invalidLocalFile)
        }

        return Observable.just(timetableEntries)
    }

}
