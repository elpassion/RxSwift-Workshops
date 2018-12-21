# Zadanie 5

### Dany jest strumień liczb (Int), w którym pojawi się błąd. Utwórz tablicę elementów, w której błąd zostanie zmapowany na wartość -1

```swift

extension String: Error {}

let resultObserver = TestObserver<Int>()
let publishSubject = PublishSubject<Int>()

publishSubject.asObservable()
    .catchErrorJustReturn(-1)
    .test(using: resultObserver)
    .subscribe()

publishSubject.onNext(1)
publishSubject.onNext(2)
publishSubject.onNext(3)
publishSubject.onNext(4)
publishSubject.onNext(5)
publishSubject.onError("Some error")
publishSubject.onNext(10)
publishSubject.onNext(11)

resultObserver.assert(valuesEqualTo: [1, 2, 3, 4, 5, -1])

```