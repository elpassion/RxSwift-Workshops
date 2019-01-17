import Foundation

struct TimetableEntry: Codable {
    let id: Int
    let name: String
    let departureTime: Date
    let departsFrom: String
    let arrivesTo: String
    let checkins: [String]

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case departureTime = "departure_time"
        case departsFrom = "departs_from"
        case arrivesTo = "arrives_to"
        case checkins
    }
}
