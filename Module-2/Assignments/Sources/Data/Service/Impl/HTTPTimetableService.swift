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

        let requestObservable: Observable<[TimetableEntry]> = Observable.create { observer in
            let dataTask = self.urlSession.dataTask(with: request) { (data, response, error) in
                let statusCode = response.flatMap { $0 as? HTTPURLResponse }.map { $0.statusCode }
                let timetable = data.flatMap { JSONDecoder.timetable(from: $0) }

                if let timetable = timetable, let statusCode = statusCode, statusCode == 200 {
                    observer.onNext(timetable.results)
                    observer.onCompleted()
                } else {
                    observer.onError(error ?? TimetableServiceError.unknown)
                }
            }

            dataTask.resume()

            return Disposables.create {
                dataTask.cancel()
            }
        }

        return requestObservable
            .observeOn(MainScheduler.instance)
    }

    // MARK: - Private

    private let apiRoute: String
    private let urlSession: URLSession

    private var timetablesRoute: String {
        return "\(apiRoute)/timetables/"
    }

}
