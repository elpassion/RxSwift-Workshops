import RxSwift

// Zadanie 1 (5min)
// Dany jest strumień elementów jadalnych (stringi/emotki). Użyj odpowiedniego operatora, aby otrzymać tylko te, które programiści lubią najbardziej. Podpowiedź: 🍕 i 🍺 :)

let resultObserver = TestObserver<String>()

Observable.of("🍕", "🍎", "🍎", "🍺", "🥕", "🍺", "🥕", "🥕", "🍺", "🍕")
    // TODO:
    .test(using: resultObserver)
    .subscribe()

resultObserver.assert(valuesEqualTo: ["🍕", "🍺", "🍺", "🍺", "🍕"])
