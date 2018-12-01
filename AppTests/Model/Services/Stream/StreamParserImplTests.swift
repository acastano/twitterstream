import XCTest

final class StreamParserImplTests: XCTestCase {
    
    func testParsing() {
        let parser = StreamParserImpl()
        let json = dictionaryFromJSONFile("twitter.json", bundle: Bundle(for: type(of: self)))

        do {
            let tweet = try parser.process(json: json ?? [:])
            XCTAssertTrue(tweet.id == 746380773926703100)
            XCTAssertTrue(tweet.text == "X just posted this limited service announcement https://t.co/3S98Iq5TWJ")
            XCTAssertTrue(tweet.name == "Rhys Southan")
            XCTAssertTrue(tweet.timestamp_ms == "1466786018245")
            XCTAssertTrue(tweet.screen_name == "rhyssouthan")
        } catch {
            XCTFail()
        }
    }

    func testParsingMissingFields() {
        let parser = StreamParserImpl()
        let json = dictionaryFromJSONFile("twitter_missing_fields.json", bundle: Bundle(for: type(of: self)))

        do {
            let tweet = try parser.process(json: json ?? [:])
            XCTAssertTrue(tweet.id == 746380773926703100)
            XCTAssertTrue(tweet.text == "X just posted this limited service announcement https://t.co/3S98Iq5TWJ")
            XCTAssertTrue(tweet.name == nil)
            XCTAssertTrue(tweet.timestamp_ms == "1466786018245")
            XCTAssertTrue(tweet.screen_name == nil)
        } catch {
            XCTFail()
        }
    }

    func testParsingInvalid() {
        let parser = StreamParserImpl()
        let json = dictionaryFromJSONFile("twitterinvalid.json", bundle: Bundle(for: type(of: self)))

        do {
            _ = try parser.process(json: json ?? [:])
            XCTFail()
        } catch {
            XCTAssertTrue(true)
        }
    }

    func testParsingCorrupted() {
        let parser = StreamParserImpl()
        let json = dictionaryFromJSONFile("twittercorrupted.json", bundle: Bundle(for: type(of: self)))

        do {
            _ = try parser.process(json: json ?? [:])
           XCTFail()
        } catch {
            XCTAssertTrue(true)
        }
    }
}
