# Dodatek 2 (5min)
### Walidacja sprawdzająca identyczność stringów wpisanych w pola i gwarantująca minimalną ilość wpisanych znaków
### Zastosowanie: zmiana hasła

```swift

let minRequiredLength = 3

func isLengthValid(_ string: String) -> Bool {
    return string.characters.count >= minRequiredLength
}

func isPairValid(_ name1: String, _ name2: String) -> Bool {
    return isLengthValid(name1) && isLengthValid(name2) && name1 == name2
}

/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
// 1

let resultObserver = TestObserver<Bool>()

let passwordSubject = PublishSubject<String>()
let confirmPasswordSubject = PublishSubject<String>()

Observable.combineLatest(passwordSubject.asObservable(),
                         confirmPasswordSubject.asObservable())
    .map { (password, confirmPassword) in isPairValid(password, confirmPassword) }
    .test(using: resultObserver)
    .subscribe()

passwordSubject.onNext("1")
passwordSubject.onNext("12")
passwordSubject.onNext("123")
confirmPasswordSubject.onNext("1")
confirmPasswordSubject.onNext("12")
confirmPasswordSubject.onNext("123")
passwordSubject.onNext("1234")
confirmPasswordSubject.onNext("1234")

resultObserver.assert(valuesEqualTo: [false, false, true, false, true])

/////////////////////////////////////////////////////////////////////////
// 2

let stackView = NSStackView(frame: NSRect(origin: CGPoint(x: 0, y: 0),
                                          size: CGSize(width: 300, height: 160)))

stackView.orientation = .vertical
stackView.distribution = .fillEqually

let nameTextView = NSTextView(frame: .zero)
nameTextView.backgroundColor = .darkGray
nameTextView.font = NSFont.systemFont(ofSize: 40)
nameTextView.string = "test1"

let repeatNameTextView = NSTextView(frame: .zero)
repeatNameTextView.backgroundColor = .darkGray
repeatNameTextView.font = NSFont.systemFont(ofSize: 40)
repeatNameTextView.string = "test2"

let resultView = NSTextView()
resultView.font = NSFont.systemFont(ofSize: 40)

stackView.addArrangedSubview(nameTextView)
stackView.addArrangedSubview(repeatNameTextView)
stackView.addArrangedSubview(resultView)

PlaygroundPage.current.liveView = stackView

/////////////////////////////////////////////////////////////////////////

extension Reactive where Base == NSTextView {
    var isValid: Binder<Bool> {
        return Binder(self.base) { textView, isValid in
            textView.backgroundColor = isValid ? .green : .red
            textView.string = isValid ? "Valid" : "Invalid"
        }
    }
}

Observable.combineLatest(nameTextView.rx.string,
                         repeatNameTextView.rx.string)
    .map { (password, confirmPassword) in isPairValid(password, confirmPassword) }
    .bind(to: resultView.rx.isValid)

```