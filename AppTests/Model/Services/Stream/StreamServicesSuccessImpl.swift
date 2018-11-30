
import Foundation

final class StreamServicesSuccessImpl: StreamServices {

    func filterByTracking(_ term: String?, completion: TweetErrorCompletion?) {
        
        completion?(tweet(), nil)
        
    }
    
    private func tweet() -> Tweet {
        
        let instance = Tweet(id:1)
        
        instance.name = "name"
        instance.text = "text"
        instance.screen_name = "screen_name"
        instance.timestamp_ms = "134567890"
        
        return instance
        
    }
    
}
