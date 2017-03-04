
import Foundation

final class StreamFilterResponse: Response {

    var tweet: Tweet?
    var error: NSError?
    
    fileprivate let parser: StreamParser
    
    init () {
                
        parser = StreamParserImpl()
        
    }
    
    func populateWithData(_ data:AnyObject?, error: NSError?) {
        
        self.error = error
        
        if self.error == nil {
            
            self.error = NSError(domain:ErrorDomain.stream.rawValue, code:0, userInfo:nil)

            if let json = data as? [String:AnyObject], let id = json[TweetAttributes.id.rawValue] as? NSNumber {
                
                tweet = parser.process(id, json:json)
              
                self.error = nil
                
            }
            
        }
        
    }
    
}
