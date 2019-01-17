import RxSwift
import XCTest

// Zadanie 3 (5min)
// Dane są dwa strumienie liczb (Int):

private let inputLeft: Observable<Int> = Observable.events([.next(3), .next(4), .next(7), .next(15), .completed])
private let inputRight: Observable<Int> = Observable.events([.next(1), .next(2), .next(21), .next(5), .next(9), .completed])

// Połącz te strumienie w jeden a następnie pobieraj elementy dopóki nie pojawi się element większy od 20.
// Edytuj tylko strumień przypisany do zmiennej `solution`.

private let solution: Observable<Int> = Observable.of(inputLeft, inputRight)
    .map { _ in 1 }

class Exercise3: XCTestCase {

    var resultObserver: TestObserver<Int>!

    override func setUp() {
        resultObserver = TestObserver()
    }

    override func tearDown() {
        resultObserver = nil
    }

    func testSolution() {
        _ = solution.test(using: resultObserver).subscribe()

        resultObserver.assert(valuesEqualTo: [3, 4, 7, 15, 1, 2])
    }

}
