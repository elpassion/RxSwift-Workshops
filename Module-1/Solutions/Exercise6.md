# Zadanie 6

### Dany jest skończony strumień liczb (Int). Użyj odpowiednich operatorów aby otrzymać tablicę, w której pominięte zostaną takie same elementy, które nastepują bezpośrednio po sobie. Edytuj tylko strumień przypisany do zmiennej `solution`.

```swift
private let input: Observable<Int> = Observable.of(1, 2, 2, 3, 4, 5, 5, 6, 7, 8, 9, 9)

private let solution: Observable<[Int]> = input
    .distinctUntilChanged()
    .toArray()
```
