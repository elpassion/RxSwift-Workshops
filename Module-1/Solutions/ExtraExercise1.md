# Dodatek 1

### Dany jest strumień liczb (Int). Użyj odpowiedniego operatora, aby w każdym pojedynczym evencie otrzymać parę liczb (Int) - (oldValue, newValue). Edytuj tylko strumień przypisany do zmiennej `solution`.

```swift
private let input: Observable<Int> = Observable.of(1, 2, 3, 4, 5, 6)

private let solution: Observable<(Int, Int)> = Observable.zip(input, input.skip(1))
    .map { ($0, $1) }
```
