import Foundation

final class StreamParserImpl: StreamParser {
    
    func process(json: [String : Any]) throws -> Tweet {

        guard let id = json[TweetAttributes.id.rawValue] as? Int else {
            throw NSError(domain:ErrorDomain.parsing.rawValue, code:0, userInfo:nil)
        }
        let text = json[TweetAttributes.text.rawValue] as? String
        let timestamp_ms = json[TweetAttributes.timestamp_ms.rawValue] as? String
        let name: String?
        let screen_name: String?
        if let user = json[TweetAttributes.user.rawValue] as? [String:Any] {
            name = user[TweetAttributes.name.rawValue] as? String
            screen_name = user[TweetAttributes.screen_name.rawValue] as? String
        } else {
            name = nil
            screen_name = nil
        }

        let instance = Tweet(id:id, text: text, name: name, screen_name: screen_name, timestamp_ms: timestamp_ms)
        return instance
    }
}
