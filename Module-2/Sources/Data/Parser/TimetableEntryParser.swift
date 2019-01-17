import Foundation

class TimetableEntriesParser: TimetableEntriesParsing {

    init(jsonDecoder: JSONDecoder = .default) {
        self.jsonDecoder = jsonDecoder
    }

    // MARK: - TimetableEntriesParsing

    func process(data: Data) -> [TimetableEntry] {
        guard let entries = try? jsonDecoder.decode([TimetableEntry].self, from: data) else { fatalError() }

        return entries
    }

    // MARK: - Private

    private let jsonDecoder: JSONDecoder

}
