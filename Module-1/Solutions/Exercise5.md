# Zadanie 5

### Dany jest strumień liczb (Int), w którym pojawi się błąd. Utwórz tablicę elementów, w której błąd zostanie zmapowany na wartość -1. Edytuj tylko strumień przypisany do zmiennej `solution`.

```swift
private let input: Observable<Int> = Observable.events([.next(1), .next(2), .next(3), .next(4), .next(5), .error("Some error")])

private let solution: Observable<Int> = input
    .catchErrorJustReturn(-1)
```
