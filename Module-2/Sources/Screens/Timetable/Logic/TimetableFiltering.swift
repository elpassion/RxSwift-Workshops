protocol TimetableFiltering {
    func apply(filter: Filter, for timetableEntries: [TimetableEntry]) -> [TimetableEntry]
}
