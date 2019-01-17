import RxSwift
import XCTest

// Zadanie 2 (5min)
// Dany jest strumień osób (stringi/emotki):

private let input = Observable.of("👮‍♀️", "👮‍♀️", "👩‍💻", "👩‍💻", "👨‍⚕️", "👮‍♀️", "👮‍♀️", "👨‍⚕️", "👨‍⚕️")

// Wybierz z niego tylko policjantów a następnie zamień ich na radiowozy.
// Edytuj tylko strumień przypisany do zmiennej `solution`.

private let solution: Observable<String> = input

class Exercise2: XCTestCase {

    var resultObserver: TestObserver<String>!

    override func setUp() {
        resultObserver = TestObserver()
    }

    override func tearDown() {
        resultObserver = nil
    }

    func testSolution() {
        _ = solution.test(using: resultObserver).subscribe()

        resultObserver.assert(valuesEqualTo: ["🚓", "🚓", "🚓", "🚓"])
    }

}
