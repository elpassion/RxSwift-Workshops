# Zadanie 3

### Dane są dwa strumienie danych typu Int. Polącz te strumienie w jeden a następnie pobieraj elementy dopóki nie pojawi się element większy od 20.

```swift

let firstSubject = PublishSubject<Int>()
let secondSubject = PublishSubject<Int>()

let resultObserver = TestObserver<Int>()

Observable.of(firstSubject.asObservable(), secondSubject.asObservable())
    .merge()
    .takeWhile { $0 < 20 }
    .test(using: resultObserver)
    .subscribe()

secondSubject.onNext(3)
secondSubject.onNext(4)
secondSubject.onNext(7)
secondSubject.onNext(15)

firstSubject.onNext(1)
firstSubject.onNext(2)
firstSubject.onNext(21)
firstSubject.onNext(5)
firstSubject.onNext(9)

resultObserver.assert(valuesEqualTo: [3, 4, 7, 15, 1, 2])

```