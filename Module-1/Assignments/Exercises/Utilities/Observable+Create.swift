import RxSwift

extension ObservableType {

    static func events(_ events: [Event<Self.E>]) -> Observable<Self.E> {
        return Observable.create { subscribe in
            events.forEach { event in
                switch event {
                case let .next(element):
                    subscribe.onNext(element)
                case let .error(error):
                    subscribe.onError(error)
                case .completed:
                    subscribe.onCompleted()
                }
            }

            return Disposables.create()
        }
    }

}
