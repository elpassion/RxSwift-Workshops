import RxCocoa
import RxSwift
import SVProgressHUD

var SVProgressHUD_show: () -> Void = SVProgressHUD.show
var SVProgressHUD_dismiss: () -> Void = SVProgressHUD.dismiss

extension Reactive where Base == UIApplication {

    var progress: Binder<Bool> {
        return Binder(self.base) { _, isVisible in
            switch isVisible {
            case true:
                SVProgressHUD_show()
            case false:
                SVProgressHUD_dismiss()
            }
        }
    }

}
