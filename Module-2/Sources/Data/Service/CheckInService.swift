import RxSwift

protocol CheckInService {
    func checkIn(timetableID: Int, username: String) -> Single<Void>
}
