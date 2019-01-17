import Foundation

class TimetableFilter: TimetableFiltering {

    init(currentDateProvider: @escaping () -> Date = { Date() }) {
        self.currentDateProvider = currentDateProvider
    }
    
    // MARK: - TimetableFiltering

    func apply(filter: Filter, for timetableEntries: [TimetableEntry]) -> [TimetableEntry] {
        return timetableEntries.filter { entry in
            shouldSelect(entry: entry, for: filter)
        }
    }

    // MARK: - Private

    private let currentDateProvider: () -> Date

    private func shouldSelect(entry: TimetableEntry, for filter: Filter) -> Bool {
        let now = currentDateProvider()
        let minutesToDeparture = entry.departureTime.timeIntervalSince(now) / 60.0

        switch filter {
        case .all:
            return minutesToDeparture >= 0.0
        case .underThirtyMinutes:
            return minutesToDeparture >= 0.0 && minutesToDeparture < 30.0
        case .thirtyToSixtyMinutes:
            return minutesToDeparture >= 30.0 && minutesToDeparture <= 60.0
        case .overSixtyMinutes:
            return minutesToDeparture > 60.0
        }
    }

}
