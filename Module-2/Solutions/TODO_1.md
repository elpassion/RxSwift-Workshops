# TODO_1

```swift
var selectedFilter: Observable<Filter> {
    return timetableView.filterView.segmentedControl.rx.selectedSegmentIndex
        .filter { $0 >= 0 }
        .map { Filter.allCases[$0] }
}

private func setUpSegments() {
    selectedFilter
        .subscribe(onNext: { [unowned self] selectedFilter in
            self.update(filter: selectedFilter, entries: self.allEntries)
        })
        .disposed(by: disposeBag)

    Filter.allCases.enumerated().forEach { index, filter in
        let segmentedControl = timetableView.filterView.segmentedControl
        segmentedControl.insertSegment(withTitle: filter.rawValue, at: index, animated: false)
    }
}

private let disposeBag = DisposeBag()
```

