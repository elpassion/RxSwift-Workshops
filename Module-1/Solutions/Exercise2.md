# Zadanie 2

### Dany jest strumień osób (stringi/emotki). Wybierz z niego tylko policjantów a następnie zamień ich na radiowozy. Edytuj tylko strumień przypisany do zmiennej `solution`.

```swift
private let input = Observable.of("👮‍♀️", "👮‍♀️", "👩‍💻", "👩‍💻", "👨‍⚕️", "👮‍♀️", "👮‍♀️", "👨‍⚕️", "👨‍⚕️")

private let solution: Observable<String> = input
    .filter { $0 == "👮‍♀️" }
    .map { _ in "🚓" }
```
