# Zadanie 2

### Dany jest strumień osób (stringi/emotki). Wybierz z niego tylko policjantów a następnie zamień ich na radiowozy.

```swift

let resultObserver = TestObserver<String>()

Observable.of("👮‍♀️", "👮‍♀️", "👩‍💻", "👩‍💻", "👨‍⚕️", "👮‍♀️", "👮‍♀️", "👨‍⚕️", "👨‍⚕️")
    .filter { $0 == "👮‍♀️" }
    .map { _ in "🚓" }
    .test(using: resultObserver)
    .subscribe()

resultObserver.assert(valuesEqualTo: ["🚓", "🚓", "🚓", "🚓"])

```