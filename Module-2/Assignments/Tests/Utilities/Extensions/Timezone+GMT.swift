import Foundation

extension TimeZone {

    static var gmt: TimeZone {
        return TimeZone(secondsFromGMT: 0)!
    }

}
