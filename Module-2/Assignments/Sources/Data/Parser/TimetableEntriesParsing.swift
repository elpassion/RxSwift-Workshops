import Foundation

protocol TimetableEntriesParsing {
    func process(data: Data) -> [TimetableEntry]
}
