
import Foundation

final class StreamServicesFailureImpl: StreamServices {

    func filterByTracking(_ term: String?, completion: TweetErrorCompletion?) {

        let error = NSError(domain: "", code:0, userInfo: nil)
        
        completion?(nil, error)
        
    }
    
}
