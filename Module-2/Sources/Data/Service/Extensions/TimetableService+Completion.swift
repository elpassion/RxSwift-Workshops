extension TimetableService {

    func fetch(completion: @escaping ([TimetableEntry]) -> Void) {
        _ = timetableEntries.take(1).subscribe(onNext: { entries in
            completion(entries)
        })
    }

}
