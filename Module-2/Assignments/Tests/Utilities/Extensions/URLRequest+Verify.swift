import OHHTTPStubs

extension URLRequest {

    func verify(method: String, urlString: String, body: Data? = nil, headers: [String: String]? = nil) -> Bool {
        return httpMethod == method && hasURL(urlString) && hasBody(body) && verifyHeaders(headers)
    }

    private func hasURL(_ urlString: String) -> Bool {
        return url == URL(string: urlString)
    }

    private func hasBody(_ body: Data?) -> Bool {
        return (self as NSURLRequest).ohhttpStubs_HTTPBody() == body
    }

    private func verifyHeaders(_ headers: [String: String]?) -> Bool {
        return headers?.first(where: { name, value in allHTTPHeaderFields?[name] != value }) == nil
    }

}
