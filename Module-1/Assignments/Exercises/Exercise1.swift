import RxSwift
import XCTest

// Zadanie 1 (5min)
// Dany jest strumień elementów jadalnych (stringi/emotki):

private let input = Observable.of("🍕", "🍎", "🍎", "🍺", "🥕", "🍺", "🥕", "🥕", "🍺", "🍕")

// Użyj odpowiedniego operatora, aby otrzymać tylko te, które programiści lubią najbardziej. Podpowiedź: 🍕 i 🍺 :)
// Edytuj tylko strumień przypisany do zmiennej `solution`.

private let solution: Observable<String> = input

class Exercise1: XCTestCase {

    var resultObserver: TestObserver<String>!

    override func setUp() {
        resultObserver = TestObserver()
    }

    override func tearDown() {
        resultObserver = nil
    }

    func testSolution() {
        _ = solution.test(using: resultObserver).subscribe()

        resultObserver.assert(valuesEqualTo: ["🍕", "🍺", "🍺", "🍺", "🍕"])
    }

}
