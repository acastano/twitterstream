
import XCTest

class DataTaskImplTests: XCTestCase {
    
    func testNoURLReturnsError() {
        
        let task = DataTaskImpl()
        
        task.loadData(nil, method: .POST, headers: [:], parameters: nil, timeout: 0) { data, error in
            
            XCTAssert(error != nil)
            
            XCTAssert(error?.domain == ErrorDomain.dataTask.rawValue)
            
        }
        
    }
    
}
