# Zadanie 4

### Dany jest skończony strumień słów (String). Ze strumienia stringów utwórz jedno zdanie.
### - pamiętaj że zdania rozpoczynamy z dużej litery
### - pamiętaj o spacjach pomiedzy słowami
### - zdanie zakończ kropką (bezpośrednio po ostatnim słowie)
### Edytuj tylko strumień przypisany do zmiennej `solution`.

```swift
private let input: Observable<String> = Observable.of("ala", "ma", "kota")

private let solution: Observable<String> = input
    .reduce("") { accumulated, word in
        [accumulated, word].filter { !$0.isEmpty }.joined(separator: " ")
    }
    .map { $0.appending(".").capitalizingFirstLetter() }
```
