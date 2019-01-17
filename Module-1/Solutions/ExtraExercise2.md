# Dodatek 2 (5min)

### Walidacja sprawdzająca identyczność stringów wpisanych w pola i gwarantująca minimalną liczbę wpisanych znaków (3). Zastosowanie: zmiana hasła.
### Poniżej znajduje się failujący test dla statycznej funkcji isValid(text:repeatedText:) znajdującej się w klasie PasswordValidationController. Napisz implementacje dla tej funkcji.
### Podpowiedź: Przed napisaniem implementacji uruchom aplikacje używając scheme `ExtraExercise2` i porównaj jej działanie po napisaniu poprawnej implementacji.

```swift
static func isValid(text: Observable<String>, repeatedText: Observable<String>) -> Observable<Bool> {
    return Observable.combineLatest(text, repeatedText)
        .map { $0 == $1 && $0.count >= 3 }
}
```
