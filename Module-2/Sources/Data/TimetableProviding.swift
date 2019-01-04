typealias TimetableFetchCompletion = ([TimetableEntry]) -> ()

protocol TimetableProviding {
    func fetch(completion: TimetableFetchCompletion)
}

