import RxSwift
import XCTest

// Zadanie dodatkowe 2 (5min)
// Walidacja sprawdzająca identyczność stringów wpisanych w pola i gwarantująca minimalną liczbę wpisanych znaków (3).
// Zastosowanie: zmiana hasła.

// Poniżej znajduje się failujący test dla statycznej funkcji isValid(text:repeatedText:)
// znajdującej się w klasie PasswordValidationController. Napisz implementacje dla tej funkcji.

// Podpowiedź:
// Przed napisaniem implementacji uruchom aplikacje używając scheme `ExtraExercise2` i porównaj
// jej działanie po napisaniu poprawnej implementacji.

class ExtraExercise2: XCTestCase {

    var resultObserver: TestObserver<Bool>!
    var passwordSubject: PublishSubject<String>!
    var confirmPasswordSubject: PublishSubject<String>!

    override func setUp() {
        resultObserver = TestObserver()
        passwordSubject = PublishSubject()
        confirmPasswordSubject = PublishSubject()
    }

    override func tearDown() {
        resultObserver = nil
        passwordSubject = nil
        confirmPasswordSubject = nil
    }

    func testIsValidMethod() {
        _ = PasswordValidationController
            .isValid(text: passwordSubject.asObservable(), repeatedText: confirmPasswordSubject.asObservable())
            .test(using: resultObserver)
            .subscribe()

        passwordSubject.onNext("1")
        passwordSubject.onNext("12")
        confirmPasswordSubject.onNext("1")
        confirmPasswordSubject.onNext("12")
        confirmPasswordSubject.onNext("123")
        passwordSubject.onNext("123")
        passwordSubject.onNext("1234")
        confirmPasswordSubject.onNext("1234")

        resultObserver.assert(valuesEqualTo: [false, false, false, true, false, true])
    }

}
