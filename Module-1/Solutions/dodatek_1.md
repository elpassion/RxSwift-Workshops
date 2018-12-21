# Dodatek 1
### oldValue / newValue

```swift

let observable = Observable.of(1, 2, 3, 4, 5, 6)
let resultObserver = TestObserver<(Int, Int)>()

Observable.zip(observable, observable.skip(1))
    .map { ($0, $1) }
    .test(using: resultObserver)
    .subscribe()

resultObserver.assert(valuesEqualTo: [(1, 2), (2, 3), (3, 4), (4, 5), (5, 6)])

```