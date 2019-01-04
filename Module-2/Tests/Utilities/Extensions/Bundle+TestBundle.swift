import Foundation

extension Bundle {

    static var testBundle: Bundle {
        let testBundle = allBundles.first { $0.bundlePath.hasSuffix(".xctest") }
        guard let bundle = testBundle else {
            fatalError("Can not find bundle with suffix .xctest")
        }
        return bundle
    }

}
