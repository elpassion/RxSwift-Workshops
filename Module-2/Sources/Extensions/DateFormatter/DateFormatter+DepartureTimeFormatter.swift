import Foundation

extension DateFormatter {

    static var departureTimeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        return formatter
    }

}
