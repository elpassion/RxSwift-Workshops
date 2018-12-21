import RxSwift

// Zadanie 2 (5min)
// Dany jest strumień osób (stringi/emotki). Wybierz z niego tylko policjantów a następnie zamień ich na radiowozy.

let resultObserver = TestObserver<String>()

Observable.of("👮‍♀️", "👮‍♀️", "👩‍💻", "👩‍💻", "👨‍⚕️", "👮‍♀️", "👮‍♀️", "👨‍⚕️", "👨‍⚕️")
    // TODO:
    .test(using: resultObserver)
    .subscribe()

resultObserver.assert(valuesEqualTo: ["🚓", "🚓", "🚓", "🚓"])
