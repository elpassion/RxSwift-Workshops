# Zadanie 6

### Dany jest skończony strumień liczb. Użyj odpowiednich operatorow aby otrzymać tablicę, w ktorej pominięte zostaną takie same elementy, które nastepują bezpośrednio po sobie.

```swift

let resultObserver = TestObserver<[Int]>()

Observable.of(1, 2, 2, 3, 4, 5, 5, 5, 6, 7, 8, 8, 9)
    .distinctUntilChanged()
    .toArray()
    .test(using: resultObserver)
    .subscribe()

resultObserver.assert(valuesEqualTo: [[1, 2, 3, 4, 5, 6 ,7 ,8 ,9]])

```