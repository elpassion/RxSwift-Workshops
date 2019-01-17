# Zadanie 3

### Dane są dwa strumienie liczb (Int). Połącz te strumienie w jeden a następnie pobieraj elementy dopóki nie pojawi się element większy od 20. Edytuj tylko strumień przypisany do zmiennej `solution`.

```swift
private let inputLeft: Observable<Int> = Observable.events([.next(3), .next(4), .next(7), .next(15), .completed])
private let inputRight: Observable<Int> = Observable.events([.next(1), .next(2), .next(21), .next(5), .next(9), .completed])

private let solution: Observable<Int> = Observable.of(inputLeft, inputRight)
    .merge()
    .takeWhile { $0 <= 20 }
```
