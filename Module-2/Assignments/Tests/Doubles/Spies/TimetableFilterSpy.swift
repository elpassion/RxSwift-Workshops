@testable import Workshops_Module2

class TimetableFilterSpy: TimetableFiltering {

    private(set) var applyInvoked: (filter: Filter, timetableEntries: [TimetableEntry])?
    private(set) var filteredEntries: [TimetableEntry]?

    private func predicate(for filter: Filter) -> (TimetableEntry) -> Bool {
        switch filter {
        case .all: return { _ in true }
        case .underThirtyMinutes: return { $0.id % 2 == 0 }
        case .thirtyToSixtyMinutes: return { $0.id % 2 != 0 }
        case .overSixtyMinutes: return { $0.id == 0 }
        }
    }

    // MARK: - TimetableFiltering

    func apply(filter: Filter, for timetableEntries: [TimetableEntry]) -> [TimetableEntry] {
        applyInvoked = (filter: filter, timetableEntries: timetableEntries)
        filteredEntries = timetableEntries.filter(predicate(for: filter))
        return filteredEntries ?? timetableEntries
    }

}
