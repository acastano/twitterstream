
import XCTest

class StreamServicesImplTests: XCTestCase {

    func testTemperatureTermSuccess() {
        
        let remote = RemoteSuccessImpl(dataTask: DataTaskTweetSuccess(), timeout: 0)
        
        let services = StreamServicesImpl(remote: remote)
        
        services.filterByTracking(nil) { tweet, error in
         
            XCTAssert(tweet != nil && error == nil)
            
        }
        
    }
    
    func testTemperatureTermFailure() {
        
        let remote = RemoteFailureImpl(dataTask: DataTaskFailure(), timeout: 0)
        
        let services = StreamServicesImpl(remote: remote)
        
        services.filterByTracking(nil) { tweet, error in
            
            XCTAssert(tweet == nil && error != nil)
            
        }
        
    }
    
}
