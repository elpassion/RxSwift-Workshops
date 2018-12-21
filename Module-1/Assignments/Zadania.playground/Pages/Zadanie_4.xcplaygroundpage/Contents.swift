import RxSwift

// Zadanie 4 (5min)
// Dany jest skończony strumień słów (Stringi), które utworzą jedno zdanie.
// - pamiętaj że zdania rozpoczynamy z dużej litery
// - pamiętaj o spacjach pomiedzy słowami
// - zdanie zakończ kropką (bezpośrednio po ostatnim słowie)

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
}

let words = PublishSubject<String>()
let expectedResult = "Ala ma kota."
let resultObserver = TestObserver<String>()

Observable.of("ala", "ma", "kota")
    // TODO:
    .test(using: resultObserver)
    .subscribe()

resultObserver.assert(valuesEqualTo: ["Ala ma kota."])
