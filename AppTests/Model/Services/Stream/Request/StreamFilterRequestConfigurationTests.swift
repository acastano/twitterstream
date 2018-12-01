import XCTest

final class StreamFilterRequestConfigurationTests: XCTestCase {
    private let request = StreamFilterRequestConfiguration(term:"term")

    func testValidURL() {
        let url = request.url()?.absoluteString
        XCTAssert(url == "https://test.com/1.1/statuses/filter.json")
    }
    
    func testNoTermParameters() {
        let request = StreamFilterRequestConfiguration(term:nil)
        let parameters = request.parameters()
        XCTAssert(parameters == "")
    }
    
    func testNoTermURL() {
        let request = StreamFilterRequestConfiguration(term:nil)
        let url = request.url()?.absoluteString
        XCTAssert(url == "https://test.com/1.1/statuses/filter.json")
    }
    
    func testValidParameters() {
        let parameters = request.parameters()
        XCTAssert(parameters == "track=term")
    }
    
    func testValidAction() {
        let action = request.action()
        XCTAssert(action == "1.1/statuses/filter.json")
    }

    func testRequestMethod() {
        let method = request.method()
        XCTAssert(method == .POST)
    }

    func testValidHeaders() {
        let headers = request.headers()
        XCTAssert(headers["Authorization"] == "OAuth oauth_consumer_key=\"hBghdh0zoPKFs5QS1tL6oRn2Z\", oauth_nonce=\"1\", oauth_signature=\"%2FmA6yTYscUgzCE9vlN1wZ2BjqX4%3D\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"1\", oauth_token=\"15122320-xn2OopZSl7DhTb12irSr5ukyzoe3G3ASgCANwu2Dc\", oauth_version=\"1.0\"")
    }
}
