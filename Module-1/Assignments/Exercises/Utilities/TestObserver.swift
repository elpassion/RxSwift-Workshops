import RxSwift
import XCTest

public class TestObserver<E> {

    public init() {}

    var events: [Event<E>] = []

}

public extension ObservableType {

    func test(using observer: TestObserver<E>) -> Observable<E> {
        return `do`(onNext: { value in observer.events.append(.next(value)) },
                    onError: { error in observer.events.append(.error(error)) },
                    onCompleted: { observer.events.append(.completed) })
    }

}

public extension TestObserver {

    func assert(eventsEqualTo expectation: [Event<E>], line: Int = #line) -> String {
        if events.debugDescription == expectation.debugDescription {
            return "✅"
        } else {
            printFailure(expectation.debugDescription, events.debugDescription, line)
            return "❌"
        }
    }

    func assert(valuesEqualTo expectation: [E], line: UInt = #line, file: StaticString = #file) {
        let result: [E] = events.compactMap {
            switch $0 {
            case .next(let value): return value
            default: return nil
            }
        }

        XCTAssertEqual(expectation.debugDescription, result.debugDescription, file: file, line: line)
    }

    private func printFailure(_ expectation: String, _ result: String, _ line: Int = #line) {
        print("""
            ❌ assertion failed (line \(line))
            Expected: \(expectation)
            Got:      \(result)
            """)
    }

}
