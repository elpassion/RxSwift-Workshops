import UIKit

let kAppDelegateClass: AnyClass = NSClassFromString("Workshops_Module2Tests.AppDelegateStub") ?? AppDelegate.self

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(kAppDelegateClass))
