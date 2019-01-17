import Foundation

extension JSONDecoder {

    static func timetable(from data: Data) -> TimetableEntryResponse? {
        return try? JSONDecoder.default.decode(TimetableEntryResponse.self, from: data)
    }

}
