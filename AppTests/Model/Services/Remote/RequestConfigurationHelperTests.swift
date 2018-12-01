import XCTest

final class RequestConfigurationHelperTests: XCTestCase {
    private let helper = RequestConfigurationHelper()
    
    func testValidURL() {
        let url = helper.url("", method:.POST)?.absoluteString
        XCTAssertEqual(url, "https://test.com/")
    }
    
    func testValidURLWithAction() {
        let url = helper.url("action", method:.POST)?.absoluteString
        XCTAssertEqual(url, "https://test.com/action")
    }
    
    func testValidAuthorisation() {
        let url = helper.url("action", method:.POST)
        let authorisation = helper.authorisation(url, params: "test=test")
        XCTAssertEqual(authorisation, "OAuth oauth_consumer_key=\"hBghdh0zoPKFs5QS1tL6oRn2Z\", oauth_nonce=\"1\", oauth_signature=\"jesV0ejJL%2Bq6hxaVjU6TV594aZQ%3D\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"1\", oauth_token=\"15122320-xn2OopZSl7DhTb12irSr5ukyzoe3G3ASgCANwu2Dc\", oauth_version=\"1.0\"")
    }
}
