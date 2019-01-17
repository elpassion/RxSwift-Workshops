import UIKit

class CheckInView: UIView {

    let container: UIStackView = Subviews.container
    let checkInLabel: UILabel = Subviews.checkInLabel
    let nameTextField: UITextField = Subviews.nameTextField
    let checkInButton: UIButton = Subviews.checkInButton

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

    private func addSubviews() {
        [checkInLabel, nameTextField, checkInButton].forEach {
            container.addArrangedSubview($0)
        }

        addSubview(container)
    }

    // MARK: - Layout

    private func setUpLayout() {
        [container, checkInLabel, checkInButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let topAnchor = container.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        topAnchor.constant = 10.0
        topAnchor.priority = UILayoutPriority(999)
        topAnchor.isActive = true

        let constraints = [
            container.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            container.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor),
            checkInLabel.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -20.0),
            nameTextField.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -20.0),
            checkInButton.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.6),
            checkInButton.heightAnchor.constraint(equalToConstant: 50.0)
        ]

        checkInLabel.setContentHuggingPriority(.required, for: .vertical)

        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { return nil }

}

private enum Subviews {

    static var container: UIStackView {
        let container = UIStackView(frame: .zero)
        container.alignment = .center
        container.axis = .vertical
        container.distribution = .equalSpacing
        container.spacing = 30.0

        return container
    }

    static var checkInLabel: UILabel {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.text = "Check-in:"

        return label
    }

    static var nameTextField: UITextField {
        let textField = UITextField(frame: .zero)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        textField.placeholder = "Type in your name..."

        return textField
    }

    static var checkInButton: UIButton {
        let button = UIButton(frame: .zero)
        button.layer.cornerRadius = 5.0
        button.layer.masksToBounds = true

        button.setBackgroundImage(UIImage.with(color: .black), for: .normal)
        button.setTitle("Check-in", for: .normal)
        button.setTitleColor(.white, for: .normal)

        return button
    }

}
