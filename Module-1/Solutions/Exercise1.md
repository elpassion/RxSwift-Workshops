# Zadanie 1

### Dany jest strumień elementów jadalnych (stringi/emotki). Użyj odpowiedniego operatora, aby otrzymać tylko te, które programiści lubią najbardziej. Podpowiedź: 🍕 i 🍺 :) Edytuj tylko strumień przypisany do zmiennej `solution`.

```swift
private let input = Observable.of("🍕", "🍎", "🍎", "🍺", "🥕", "🍺", "🥕", "🥕", "🍺", "🍕")

private let solution: Observable<String> = input
    .filter { Set(["🍕", "🍺"]).contains($0) }
```
