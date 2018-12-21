import RxSwift

// Zadanie 3 (5min)
// Dane są dwa strumienie danych typu Int. Polącz te strumienie w jeden a następnie pobieraj elementy dopóki nie pojawi się element większy od 20.

let firstSubject = PublishSubject<Int>()
let secondSubject = PublishSubject<Int>()
let resultObserver = TestObserver<Int>()

// TODO:
let resultObservable: Observable<Int> = .empty()

resultObservable
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
