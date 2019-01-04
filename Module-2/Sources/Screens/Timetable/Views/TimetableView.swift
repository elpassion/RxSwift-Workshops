import UIKit

class TimetableView: UIView {

    init() {
        super.init(frame: .zero)

        setUpSelf()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Configuration

    private func setUpSelf() {
        backgroundColor = .white
    }

    // MARK: - Subviews

    let filterView = FilterView()
    let tableView = Subviews.tableView

    private func addSubviews() {
        stackView.addArrangedSubview(filterView)
        stackView.addArrangedSubview(tableView)
        addSubview(stackView)
    }

    private let stackView = Subviews.stackView

    // MARK: - Layout

    private func setUpLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}

private enum Subviews {

    static var tableView: UITableView {
        let view = UITableView()
        view.rowHeight = 40.0
        view.tableFooterView = UIView(frame: .zero)
        view.register(TimetableEntryCell.self, forCellReuseIdentifier: "TimetableCell")

        return view
    }

    static var stackView: UIStackView {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = UIStackView.spacingUseDefault

        return stackView
    }

}
