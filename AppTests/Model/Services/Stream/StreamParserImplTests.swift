
import XCTest

class StreamParserImplTests: XCTestCase {
    
    func testParsing() {
        
        let parser = StreamParserImpl()
        
        let json = dictionaryFromJSONFile("twitter.json", bundle: Bundle(for: type(of: self))) as! [String:AnyObject]
        
        let tweet = parser.process(1, json: json)
        
        XCTAssertTrue(tweet.id == 1)
        XCTAssertTrue(tweet.text == "X just posted this limited service announcement https://t.co/3S98Iq5TWJ")
        XCTAssertTrue(tweet.name == "Rhys Southan")
        XCTAssertTrue(tweet.timestamp_ms == "1466786018245")
        XCTAssertTrue(tweet.screen_name == "rhyssouthan")
    
    }
    
}
