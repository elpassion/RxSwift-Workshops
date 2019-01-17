import RxSwift
import XCTest

// Zadanie dodatkowe 1 (5min)
// Dany jest strumień liczb (Int):

private let input: Observable<Int> = Observable.of(1, 2, 3, 4, 5, 6)

// Użyj odpowiedniego operatora, aby w każdym pojedynczym evencie otrzymać parę liczb (Int) - (oldValue, newValue).
// Edytuj tylko strumień przypisany do zmiennej `solution`.

private let solution: Observable<(Int, Int)> = input
    .map { ($0, $0) }

class ExtraExercise1: XCTestCase {

    var resultObserver: TestObserver<(Int, Int)>!

    override func setUp() {
        resultObserver = TestObserver()
    }

    override func tearDown() {
        resultObserver = nil
    }

    func testSolution() {
        _ = solution.test(using: resultObserver).subscribe()

        resultObserver.assert(valuesEqualTo: [(1, 2), (2, 3), (3, 4), (4, 5), (5, 6)])
    }

}
