struct TimetableEntryResponse: Codable {
    let count: Int
    let nextPage: Int?
    let previousPage: Int?
    let results: [TimetableEntry]

    private enum CodingKeys: String, CodingKey {
        case count
        case nextPage = "next"
        case previousPage = "previous"
        case results
    }
}
