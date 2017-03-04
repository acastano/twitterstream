
import XCTest

class RequestConfigurationHelperTests: XCTestCase {

    fileprivate let helper = RequestConfigurationHelper()
    
    
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
                
        XCTAssertEqual(authorisation, "OAuth oauth_consumer_key=\"ENTER KEY THE KEY\", oauth_nonce=\"1\", oauth_signature=\"Cij3NAPTC5WKcc6Xpp6jWtJRcHw%3D\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"1\", oauth_token=\"ENTER HERE THE TOKEN\", oauth_version=\"1.0\"")
        
    }

}
