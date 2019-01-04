W klasie `HTTPTimetableService` zaimplementowano pobieranie danych z wykorzystaniem `Observable.create`. Uprość kod za pomocą metody `.rx.response` na `URLSession` i wykorzystaniu funkcji `flatMap`. 

```swift
import Foundation
import RxSwift

class HTTPTimetableService: TimetableService {

    init(apiRoute: String = "http://peaceful-fortress-94735.herokuapp.com/api/v1",
         urlSession: URLSession = .shared) {
        self.apiRoute = apiRoute
        self.urlSession = urlSession
    }

    // MARK: - TimetableService

    var timetableEntries: Observable<[TimetableEntry]> {
        guard let url = URL(string: timetablesRoute) else {
            fatalError("Could not build URL: \(timetablesRoute)")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return urlSession.rx.response(request: request)
            .flatMap { result -> Observable<[TimetableEntry]> in
                guard let timetable = JSONDecoder.timetable(from: result.data), result.response.statusCode == 200 else {
                    return .error(TimetableServiceError.unknown)
                }

                return .just(timetable.results)
            }
            .observeOn(MainScheduler.instance)
    }

    // MARK: - Private

    private let apiRoute: String
    private let urlSession: URLSession

    private var timetablesRoute: String {
        return "\(apiRoute)/timetables/"
    }

}
```