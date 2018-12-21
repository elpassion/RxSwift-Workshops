# Zadanie 1

### Dany jest strumień elementów jadalnych (stringi/emotki). Użyj odpowiedniego operatora, aby otrzymać tylko te, które programiści lubią najbardziej. Podpowiedź: 🍕 i 🍺 :)

```swift

let resultObserver = TestObserver<String>()

Observable.of("🍕", "🍎", "🍎", "🍺", "🥕", "🍺", "🥕", "🥕", "🍺", "🍕")
    .filter { $0 == "🍕" || $0 == "🍺" }
    .test(using: resultObserver)
    .subscribe()

resultObserver.assert(valuesEqualTo: ["🍕", "🍺", "🍺", "🍺", "🍕"])

```