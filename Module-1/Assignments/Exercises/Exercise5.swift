import RxSwift
import XCTest

// Zadanie 5 (5min)
// Dany jest strumień liczb (Int), w którym pojawi się błąd.

private let input: Observable<Int> = Observable.events([.next(1), .next(2), .next(3), .next(4), .next(5), .error("Some error")])

// Utwórz tablicę elementów, w której błąd zostanie zmapowany na wartość -1.
// Edytuj tylko strumień przypisany do zmiennej `solution`.

private let solution: Observable<Int> = input

class Exercise5: XCTestCase {

    var resultObserver: TestObserver<Int>!

    override func setUp() {
        resultObserver = TestObserver()
    }

    override func tearDown() {
        resultObserver = nil
    }

    func testSolution() {
        _ = solution.test(using: resultObserver).subscribe()

        resultObserver.assert(valuesEqualTo: [1, 2, 3, 4, 5, -1])
    }

}
