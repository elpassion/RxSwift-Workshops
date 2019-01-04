@testable import Workshops_Module2
import Foundation

extension TimeTableCellPresenter {

    static var testInstance: TimeTableCellPresenter {
        return TimeTableCellPresenter(departureTimeFormatter: DateFormatter.departureTimeFormatter.withGMT)
    }

}
