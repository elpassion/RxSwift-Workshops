import Foundation

extension Bundle {

    static func jsonData(forName name: String) -> Data {
        guard let filepath = testBundle.path(forResource: name, ofType: "json") else {
            fatalError("Could not load test resource `\(name).json` from test bundle")
        }

        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filepath)) else {
            fatalError("Could not read data from `\(name).json`")
        }

        return jsonData
    }

}
