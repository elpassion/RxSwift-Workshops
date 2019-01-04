# TODO_2

```swift
private func setUpTableViewDataSource() {
    Observable
        .combineLatest(timetableService.timetableEntries, selectedFilter)
        { [timetableFilter] entries, selectedFilter -> [TimetableEntry] in
            let sortedEntries = entries.sorted { $0.departureTime < $1.departureTime }
            return timetableFilter.apply(filter: selectedFilter, for: sortedEntries)
        }
        .asDriver(onErrorDriveWith: .just([]))
        .drive(timetableView.tableView.rx.items(cellIdentifier: "TimetableCell"))
        { [weak self] (_, entry, cell: TimetableEntryCell) in
            self?.configure(cell: cell, with: entry)
        }
        .disposed(by: disposeBag)
}
```
