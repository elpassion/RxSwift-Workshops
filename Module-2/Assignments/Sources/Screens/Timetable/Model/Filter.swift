import Foundation

enum Filter: String, CaseIterable {
    case all = "All"
    case underThirtyMinutes = "<30 min"
    case thirtyToSixtyMinutes = "30-60 min"
    case overSixtyMinutes = ">60 min"
}
