# TODO_3

```swift
cell.checkInButton.rx.tap.asObservable()
    .map { entry.id }
    .subscribe(onNext: { [weak self] timetableID in
        self?.pushCheckInViewController(timetableID: timetableID)
    })
    .disposed(by: cell.disposeBag)
```
