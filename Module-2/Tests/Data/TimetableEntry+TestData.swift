@testable import Workshops_Module2

extension TimetableEntry {

    static var testEntries: [TimetableEntry] {
        return [
            TimetableEntry(id: 1, name: "EIP 1", departureTime: "2017-12-27 14:00:00".date(), departsFrom: "", arrivesTo: "", checkins: []),
            TimetableEntry(id: 2, name: "EIP 2", departureTime: "2017-12-28 15:00:00".date(), departsFrom: "", arrivesTo: "", checkins: []),
            TimetableEntry(id: 3, name: "EIP 3", departureTime: "2017-12-27 16:42:00".date(), departsFrom: "", arrivesTo: "", checkins: []),
            TimetableEntry(id: 4, name: "EIP 4", departureTime: "2017-12-27 16:37:00".date(), departsFrom: "", arrivesTo: "", checkins: []),
            TimetableEntry(id: 5, name: "EIP 5", departureTime: "2017-12-27 17:12:00".date(), departsFrom: "", arrivesTo: "", checkins: [])
        ]
    }

}
