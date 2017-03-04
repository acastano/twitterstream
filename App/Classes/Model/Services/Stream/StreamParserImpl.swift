
import Foundation

final class StreamParserImpl: StreamParser {
    
    func process(_ id:NSNumber, json: [String : AnyObject]) -> Tweet {
    
        let instance = Tweet(id:id)
        
        instance.text = json[TweetAttributes.text.rawValue] as? String
        instance.timestamp_ms = json[TweetAttributes.timestamp_ms.rawValue] as? String
        
        if let user = json[TweetAttributes.user.rawValue] as? [String:AnyObject] {
        
            instance.name = user[TweetAttributes.name.rawValue] as? String
            instance.screen_name = user[TweetAttributes.screen_name.rawValue] as? String
        
        }
        
        return instance
        
    }
    
}
