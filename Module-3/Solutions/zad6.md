```swift
import RxCocoa
import RxSwift
import UIKit

class CheckInViewController: UIViewController {

    let timetableID: Int

    init(timetableID: Int, checkInService: CheckInService = DefaultCheckInService()) {
        self.timetableID = timetableID
        self.checkInService = checkInService

        super.init(nibName: nil, bundle: nil)
    }

    var checkInView: CheckInView! {
        return view as? CheckInView
    }

    var checkInComplete: Observable<Void> {
        return checkInStatusSubject.filter { $0 == .success }.map { _ in () }
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = CheckInView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Check In"
        setupBindings()
    }

    // MARK: - Private

    private let checkInService: CheckInService
    private let disposeBag: DisposeBag = DisposeBag()
    private let checkInStatusSubject = PublishSubject<CheckInStatus>()

    private func setupBindings() {
        checkInView.checkInButton.rx.tap
            .withLatestFrom(checkInView.nameTextField.rx.text.orEmpty)
            .flatMapLatest { [checkInService, timetableID] name in
                checkInService.checkIn(timetableID: timetableID, username: name)
                    .map { .success }
                    .catchErrorJustReturn(.error)
            }
            .bind(to: checkInStatusSubject)
            .disposed(by: disposeBag)

        checkInComplete
            .subscribe(onNext: { [weak self] in
                _ = self?.popController?(true)
            })
            .disposed(by: disposeBag)
    }

    lazy var popController: ((Bool) -> UIViewController?)? = navigationController?.popViewController(animated:)

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
```
