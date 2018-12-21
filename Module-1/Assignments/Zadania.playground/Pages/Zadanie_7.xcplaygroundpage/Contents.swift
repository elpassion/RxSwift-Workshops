import RxSwift

// Zadanie 7 (10min)
// Dana jest sekwencja opcjonalnych Intów. Zignoruj nile oraz wartości spoza przedziału 0-9. Zbuduj tablicę numerów telefonów w podanym formacie ["123-456-789", "234-567-890", ...]. Każdy numer telefonu musi mieć dokladnie 9 cyfr

let resultObserver = TestObserver<String>()

Observable.of(2,   6,   8,    3, nil, 24, -1, 8, 4,  8,
              9,  41,   1, -109,   0,  9, 16, 4, 6, -2,
              8,   9,   1,    9,   1,  2,  7, 5, 3,  1,
              9,   3,   3,    4, nil,  8, -1, 9, 2,  9,
              4, -44, 111,  nil,   1,  6)
    // TODO:
    .map { _ in "XXX-XXX-XXX" }
    .test(using: resultObserver)
    .subscribe()

resultObserver.assert(valuesEqualTo: ["268-384-891", "094-689-191", "275-319-334"])

extension ObservableType {

    func buffer(count: Int) -> Observable<[Self.E]> {
        return scan([Self.E]()) { $0.count == count ? [$1] : $0 + [$1] }
            .filter { $0.count == count }
    }

}
