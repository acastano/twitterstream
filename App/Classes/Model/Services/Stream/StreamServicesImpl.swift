
import Foundation

final class StreamServicesImpl: StreamServices {
    
    fileprivate let remote: Remote
    fileprivate var completion: TweetErrorCompletion?

    init (remote: Remote) {
        
        self.remote = remote
        
    }
    
    func filterByTracking(_ term:String?, completion:TweetErrorCompletion?) {

        self.completion = completion
        
        let request = StreamFilterRequestConfiguration(term:term)
        
        let response = StreamFilterResponse()
        
        remote.makeRequest(request, response: response) { 
            
            completion?(response.tweet, response.error)
            
        }
        
    }
    
}
