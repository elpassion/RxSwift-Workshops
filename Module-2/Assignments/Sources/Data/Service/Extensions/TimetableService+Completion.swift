extension TimetableService {

    func fetch(completion: @escaping ([TimetableEntry]) -> Void) {
        _ = timetableEntries
            .subscribe(
                onNext: { entries in completion(entries) },
                onError: { _ in completion([]) }
            )
    }

}
