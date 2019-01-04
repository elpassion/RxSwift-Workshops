import RxSwift
import Starscream

class WebSocketTimetableService: TimetableService {

    init(webSocketFactory: @escaping (URL) -> WebSocket = { url in WebSocket(url: url) },
         apiRoute: String = "ws://peaceful-fortress-94735.herokuapp.com") {
        self.webSocketFactory = webSocketFactory
        self.apiRoute = apiRoute
    }
    
    // MARK: - TimetableService

    var timetableEntries: Observable<[TimetableEntry]> {
        guard let timetablesURL = URL(string: timetablesRoute) else {
            fatalError("Could not build URL for timetables websocket route: \(timetablesRoute)")
        }

        let socketObservable: Observable<[TimetableEntry]> = Observable.create { observer in
            let webSocket = self.webSocketFactory(timetablesURL)

            webSocket.onText = { text in
                let timetables = text
                    .data(using: .utf8)
                    .flatMap { try? JSONDecoder.default.decode([TimetableEntry].self, from: $0) }

                if let timetables = timetables {
                    observer.onNext(timetables)
                }
            }

            webSocket.onDisconnect = { error in
                observer.onError(error ?? TimetableServiceError.unknown)
            }

            webSocket.connect()

            return Disposables.create {
                webSocket.disconnect()
            }
        }

        return socketObservable
            .observeOn(MainScheduler.instance)
    }
    
    // MARK: - Private

    private let webSocketFactory: (URL) -> WebSocket
    private let apiRoute: String

    private var timetablesRoute: String {
        return "\(apiRoute)/timetables/"
    }

}
