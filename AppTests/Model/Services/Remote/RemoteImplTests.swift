
import XCTest

class RemoteImplTests: XCTestCase {
    
    func testSuccess() {
        
        let remote = RemoteImpl(dataTask: DataTaskTweetSuccess(), timeout: 0)
        
        let response = StreamFilterResponse()
        
        remote.makeRequest(StreamFilterRequestConfiguration(term: nil), response: response) {
            
            XCTAssert(response.error == nil && response.tweet != nil)
            
        }
        
    }
    
    func testFailureCorrupted() {
        
        let remote = RemoteImpl(dataTask: DataTaskCorrupted(), timeout: 0)
        
        let response = StreamFilterResponse()
        
        remote.makeRequest(StreamFilterRequestConfiguration(term: nil), response: response) {
            
            XCTAssert(response.error != nil && response.tweet == nil)
            
        }
        
    }
    
    func testFailure() {
        
        let remote = RemoteImpl(dataTask: DataTaskFailure(), timeout: 0)
        
        let response = StreamFilterResponse()
        
        remote.makeRequest(StreamFilterRequestConfiguration(term: nil), response: response) {
         
            XCTAssert(response.error != nil && response.tweet == nil)
            
        }
        
    }
    
}
