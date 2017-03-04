
import Foundation

final class StreamServicesMultipleSuccessImpl: StreamServices {

    fileprivate var calls = 0
    
    func filterByTracking(_ term: String?, completion: TweetErrorCompletion?) {
        
        completion?(tweet(calls), nil)
        
        calls = calls + 1
        
    }
    
    fileprivate func tweet(_ id:Int) -> Tweet {
        
        let instance = Tweet(id:NSNumber(value:id))
        
        return instance
        
    }
    
}
