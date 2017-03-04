
import XCTest

class AppDelegateTests: XCTestCase {
    
    func testAppDelegateSetControllerAsRoot() {
        
        let appDelegate = AppDelegate()
        
        _ = appDelegate.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        
        XCTAssertTrue(appDelegate.window?.rootViewController is TweetListViewController)
        
    }
    
}

