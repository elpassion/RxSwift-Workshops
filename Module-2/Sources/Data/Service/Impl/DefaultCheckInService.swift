import Foundation
import RxSwift

class DefaultCheckInService: CheckInService {

    init(apiRoute: String = "http://peaceful-fortress-94735.herokuapp.com/api/v1",
         urlSession: URLSession = .shared) {
        self.apiRoute = apiRoute
        self.urlSession = urlSession
    }
    
    // MARK: - CheckInService

    func checkIn(timetableID: Int, username: String) -> Single<Void> {
        guard let url = URL(string: checkInRoute(timetableID: timetableID)) else {
            fatalError("Could not build URL from \(checkInRoute(timetableID: timetableID))")
        }

        var request = URLRequest(url: url)
        request.httpBody = try? JSONEncoder().encode(CheckIn(username: username))
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestObservable: Single<Void> = Single.create { single in
            let dataTask = self.urlSession.dataTask(with: request) { (data, response, error) in
                let httpStatus = response.flatMap { $0 as? HTTPURLResponse }.map { $0.statusCode }
                let timetableEntry = data.flatMap { try? JSONDecoder.default.decode(TimetableEntry.self, from: $0) }

                guard let timetable = timetableEntry, let statusCode = httpStatus, statusCode == 200 else {
                    single(.error(error ?? CheckInServiceError.unknown))
                    return
                }

                if timetable.checkins.contains(username) {
                    single(.success(()))
                } else {
                    single(.error(CheckInServiceError.notCheckedIn))
                }
            }

            dataTask.resume()

            return Disposables.create {
                dataTask.cancel()
            }
        }

        return requestObservable
            .map { _ in () }
            .observeOn(MainScheduler.instance)
    }

    // MARK: - Private

    private let apiRoute: String
    private let urlSession: URLSession

    private func checkInRoute(timetableID: Int) -> String {
        return "\(apiRoute)/timetables/\(timetableID)/checkin/"
    }

}
