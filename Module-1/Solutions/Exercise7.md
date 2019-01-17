# Zadanie 7

### Dany jest strumień opcjonalnych liczb (Int?). Zignoruj nile oraz wartości spoza przedziału 0-9. Zbuduj tablicę numerów telefonów w podanym formacie ["123-456-789", "234-567-890", ...]. Każdy numer telefonu musi mieć dokladnie 9 cyfr. Edytuj tylko strumień przypisany do zmiennej `solution`.

```swift
private let input: Observable<Int?> = Observable.of(2,   6,   8,    3, nil, 24, -1, 8, 4,  8,
                                                    9,  41,   1, -109,   0,  9, 16, 4, 6, -2,
                                                    8,   9,   1,    9,   1,  2,  7, 5, 3,  1,
                                                    9,   3,   3,    4, nil,  8, -1, 9, 2,  9,
                                                    4, -44, 111,  nil,   1,  6)

private let solution: Observable<String> = input
    .filter { $0 != nil && (0..<10).contains($0!) }
    .map { String($0!) }
    .buffer(count: 3)
    .map { $0.joined(separator: "") }
    .buffer(count: 3)
    .map { $0.joined(separator: "-") }
```
