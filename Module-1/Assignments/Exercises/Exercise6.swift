import RxSwift
import XCTest

// Zadanie 6 (5min)
// Dany jest skończony strumień liczb (Int):

private let input: Observable<Int> = Observable.of(1, 2, 2, 3, 4, 5, 5, 6, 7, 8, 9, 9)

// Użyj odpowiednich operatorów aby otrzymać tablicę, w której pominięte
// zostaną takie same elementy, które nastepują bezpośrednio po sobie.
// Edytuj tylko strumień przypisany do zmiennej `solution`.

private let solution: Observable<[Int]> = input
    .map { _ in [] }

class Exercise6: XCTestCase {

    var resultObserver: TestObserver<[Int]>!

    override func setUp() {
        resultObserver = TestObserver()
    }

    override func tearDown() {
        resultObserver = nil
    }

    func testSolution() {
        _ = solution.test(using: resultObserver).subscribe()

        resultObserver.assert(valuesEqualTo: [[1, 2, 3, 4, 5, 6, 7, 8, 9]])
    }

}
