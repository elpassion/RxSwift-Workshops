import RxSwift
import UIKit

class TimetableEntryCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUpSelf()
        addSubviews()
        setUpLayout()
        setUpCheckInButtonAction()
    }

    var didTapCheckInButton: (() -> Void)?

    // MARK: - Configuration

    private func setUpSelf() {
        selectionStyle = .none
    }

    // MARK: - Reusing

    private(set) var disposeBag: DisposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()

        disposeBag = DisposeBag()
        timeLabel.text = nil
        nameLabel.text = nil
        didTapCheckInButton = nil
    }

    // MARK: - Subviews

    let timeLabel = Subviews.timeLabel
    let nameLabel = Subviews.nameLabel
    let checkInButton = Subviews.checkInButton

    private func addSubviews() {
        [timeLabel, nameLabel, checkInButton].forEach {
            contentView.addSubview($0)
        }
    }

    // MARK: - Layout

    private func setUpLayout() {
        [timeLabel, nameLabel, checkInButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let constraints = [
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            timeLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor),
            timeLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
            nameLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            checkInButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            checkInButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkInButton.heightAnchor.constraint(equalToConstant: 30),
            checkInButton.widthAnchor.constraint(equalToConstant: 30),
            checkInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]

        timeLabel.setContentHuggingPriority(.required, for: .horizontal)
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Actions

    private func setUpCheckInButtonAction() {
        checkInButton.addTarget(self, action: #selector(didTapOnButton), for: .touchUpInside)
    }

    @objc private func didTapOnButton() {
        didTapCheckInButton?()
    }

    // MARK: - Required init

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}

private enum Subviews {

    static var timeLabel: UILabel {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)

        return label
    }

    static var nameLabel: UILabel {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)

        return label
    }

    static var checkInButton: UIButton {
        let button = UIButton(frame: .zero)
        button.setImage(#imageLiteral(resourceName: "check_in"), for: .normal)

        return button
    }

}
