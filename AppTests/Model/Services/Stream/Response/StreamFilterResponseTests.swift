
import XCTest

class StreamFilterResponseTests: XCTestCase {

    fileprivate let response = StreamFilterResponse()
    
    func testPopulateReturnsTweetWithValidJSON() {
        
        let json = dictionaryFromJSONFile("twitter.json", bundle: Bundle(for: type(of: self)))
        
        response.populateWithData(json, error: nil)
        
        XCTAssert(response.tweet != nil)
        
    }
    
    func testPopulateReturnsErrorWithInvalidJSON() {
        
        let json = dictionaryFromJSONFile("twitterinvalid.json", bundle: Bundle(for: type(of: self)))
        
        response.populateWithData(json, error: nil)
        
        XCTAssert(response.error != nil)
        
        XCTAssert(response.error?.domain == ErrorDomain.stream.rawValue)
        
    }
    
    func testErrorIsSet() {
        
        let error = NSError(domain: "", code: 0, userInfo: nil)
        
        response.populateWithData(nil, error: error)
        
        XCTAssert(response.error != nil)
        
    }

}
