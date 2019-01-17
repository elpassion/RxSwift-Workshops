import Foundation

class TimeTableCellPresenter {

    init(departureTimeFormatter: DateFormatter = .departureTimeFormatter) {
        self.departureTimeFormatter = departureTimeFormatter
    }

    func present(model: TimetableEntry, in cell: TimetableEntryCell) {
        cell.nameLabel.text = model.name
        cell.timeLabel.text = departureTimeFormatter.string(from: model.departureTime)
    }

    // MARK: - Private

    private let departureTimeFormatter: DateFormatter

}
