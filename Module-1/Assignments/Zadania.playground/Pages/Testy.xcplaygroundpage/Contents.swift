import RxSwift

// ARRANGE

let subject = PublishSubject<Int>()
let observer = TestObserver<Int>()
subject.test(using: observer).subscribe()

// ACT

subject.onNext(1)
subject.onNext(2)
subject.onNext(3)

// ASSERT

observer.assert(valuesEqualTo: [1, 2, 3]) // test next events only, should pass
observer.assert(eventsEqualTo: [.next(1), .next(2), .next(3)]) // test events, should pass

observer.assert(valuesEqualTo: [3, 2, 1]) // should fail
observer.assert(eventsEqualTo: [.next(3), .next(2), .next(1)]) // should fail

