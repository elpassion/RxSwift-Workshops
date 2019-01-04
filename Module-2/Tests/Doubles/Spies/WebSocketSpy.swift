import Starscream

class WebSocketSpy: WebSocket {

    private(set) var didConnect: Bool = false
    private(set) var didDisconnect: Bool = false

    // MARK: - WebSocket

    override func connect() {
        didConnect = true
    }

    override func disconnect(forceTimeout: TimeInterval?, closeCode: UInt16) {
        didDisconnect = true
    }

}
