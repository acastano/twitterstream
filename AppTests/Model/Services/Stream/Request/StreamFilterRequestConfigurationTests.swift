
import XCTest

class StreamFilterRequestConfigurationTests: XCTestCase {
    
    fileprivate let request = StreamFilterRequestConfiguration(term:"term")

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
    
}
