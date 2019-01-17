import RxSwift

extension ObservableType {

    func buffer(count: Int) -> Observable<[Self.E]> {
        return scan([Self.E]()) { $0.count == count ? [$1] : $0 + [$1] }
            .filter { $0.count == count }
    }

}
