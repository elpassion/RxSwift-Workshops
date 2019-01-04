import Foundation

class TimetableFileProvider: TimetableProviding {

    init(parser: TimetableEntriesParsing = TimetableEntriesParser()) {
        self.parser = parser
    }

    // MARK: - Interface

    func fetch(completion: ([TimetableEntry]) -> ()) {
        let data = exampleFileData()
        let entries = parser.process(data: data)

        completion(entries)
    }

    // MARK: - Private

    private let parser: TimetableEntriesParsing

    // MARK: Mock data

    private func exampleFileData() -> Data {
        guard let exampleFilePath = Bundle.main.url(forResource: "Example", withExtension: "JSON") else { fatalError() }
        guard let data = try? Data(contentsOf: exampleFilePath) else { fatalError() }

        return data
    }

}
