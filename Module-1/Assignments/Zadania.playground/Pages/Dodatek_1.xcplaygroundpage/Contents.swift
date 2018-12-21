import RxSwift

// Dodatek 1
// oldValue / newValue

let observable = Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
let disposeBag = DisposeBag()

Observable.zip(observable, observable.skip(1))
    .subscribe(onNext: { print("oldValue: \($0.0), newValue: \($0.1)") })
    .disposed(by: disposeBag)
