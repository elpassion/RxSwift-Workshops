import Foundation

extension DateFormatter {

    var withGMT: DateFormatter {
        self.timeZone = .gmt
        return self
    }

}
