import Cocoa
import RxCocoa
import RxSwift

extension Reactive where Base == NSTextView {

    var isValid: Binder<Bool> {
        return Binder(self.base) { textView, isValid in
            textView.backgroundColor = isValid ? .green : .red
            textView.string = isValid ? "Valid" : "Invalid"
        }
    }

}
