import UIKit

class FilterView: UIView {

    let segmentedControl = Subviews.filterSegmentedControl

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func addSubviews() {
        addSubview(segmentedControl)
        addSubview(label)
    }

    private let label = Subviews.filterLabel

    // MARK: - Layout

    private func setUpLayout() {
        [label, segmentedControl].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let constraints = [
            label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            segmentedControl.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 14),
            segmentedControl.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -14),
            segmentedControl.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            segmentedControl.heightAnchor.constraint(equalToConstant: 35)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}

private enum Subviews {

    static var filterLabel: UILabel {
        let label = UILabel(frame: .zero)
        label.text = "Departs in:"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)

        return label
    }

    static var filterSegmentedControl: UISegmentedControl {
        let control = UISegmentedControl()
        control.backgroundColor = .white

        return control
    }

}
