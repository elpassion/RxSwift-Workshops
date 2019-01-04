import Foundation

extension String {

    func date() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = .gmt

        guard let date = formatter.date(from: self) else {
            fatalError("\(self) is not a date in test format (yyyy-MM-dd HH:mm:ss)")
        }

        return date
    }

}
