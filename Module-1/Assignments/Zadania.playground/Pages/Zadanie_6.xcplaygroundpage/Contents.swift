import RxSwift

// Zadanie 6 (5min)
// Dany jest skończony strumień liczb. Użyj odpowiednich operatorow aby otrzymać tablicę, w ktorej pominięte zostaną takie same elementy, które nastepują bezpośrednio po sobie.

let subject = PublishSubject<Int>()
let resultObserver = TestObserver<[Int]>()

// TODO:
let resultObservable: Observable<[Int]> = .empty()

resultObservable
    // TODO:
    .test(using: resultObserver)
    .subscribe()

subject.onNext(1)
subject.onNext(2)
subject.onNext(2)
subject.onNext(3)
subject.onNext(4)
subject.onNext(5)
subject.onNext(5)
subject.onNext(6)
subject.onNext(7)
subject.onNext(8)
subject.onNext(9)
subject.onNext(9)

resultObserver.assert(valuesEqualTo: [[1, 2, 3, 4, 5, 6 ,7 ,8 ,9]])
