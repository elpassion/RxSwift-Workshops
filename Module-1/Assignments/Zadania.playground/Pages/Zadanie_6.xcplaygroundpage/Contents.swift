import RxSwift

// Zadanie 6 (5min)
// Dany jest skończony strumień liczb. Użyj odpowiednich operatorow aby otrzymać tablicę, w ktorej pominięte zostaną takie same elementy, które nastepują bezpośrednio po sobie.

let subject = PublishSubject<Int>()
let resultObserver = TestObserver<[Int]>()

Observable.of(1, 2, 2, 3, 4, 5, 5, 6, 7, 8, 8, 9)
    // TODO:
    .test(using: resultObserver)
    .subscribe()

resultObserver.assert(valuesEqualTo: [[1, 2, 3, 4, 5, 6 ,7 ,8 ,9]])
