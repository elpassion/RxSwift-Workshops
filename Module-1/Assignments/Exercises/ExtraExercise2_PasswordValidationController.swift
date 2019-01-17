import AppKit
import Cocoa
import RxSwift
import RxCocoa

class PasswordValidationController: NSViewController {

    // MARK: - Validation

    static func isValid(text: Observable<String>, repeatedText: Observable<String>) -> Observable<Bool> {
        // TODO:
        return Observable.just(false)
    }

    // MARK - Lifecycle

    override func loadView() {
        view = stackView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpLayout()
        setUpTextViewsBinding()
    }

    // MARK: - Bindings

    private func setUpTextViewsBinding() {
        let password = passwordTextView.rx.string.asObservable()
        let confirmPassword = confirmPasswordTextView.rx.string.asObservable()

        PasswordValidationController
            .isValid(text: password, repeatedText: confirmPassword)
            .bind(to: resultView.rx.isValid)
            .disposed(by: disposeBag)
    }

    // MARK: - Layout

    let stackView = NSStackView(frame: NSRect(origin: .zero, size: CGSize(width: 500, height: 200)))
    let passwordTextView = NSTextView(frame: .zero)
    let confirmPasswordTextView = NSTextView(frame: .zero)
    let resultView = NSTextView()

    private func setUpLayout() {
        stackView.orientation = .vertical
        stackView.distribution = .fillEqually

        passwordTextView.backgroundColor = .darkGray
        passwordTextView.font = .systemFont(ofSize: 40)
        passwordTextView.string = "test1"

        confirmPasswordTextView.backgroundColor = .darkGray
        confirmPasswordTextView.font = .systemFont(ofSize: 40)
        confirmPasswordTextView.string = "test2"

        resultView.font = .systemFont(ofSize: 40)

        stackView.addArrangedSubview(passwordTextView)
        stackView.addArrangedSubview(confirmPasswordTextView)
        stackView.addArrangedSubview(resultView)
    }

    // MARK: - Private

    private let disposeBag = DisposeBag()

}
