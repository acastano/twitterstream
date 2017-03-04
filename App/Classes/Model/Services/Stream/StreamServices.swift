
import Foundation

typealias TweetErrorCompletion = (Tweet?, NSError?) -> ()

protocol StreamServices {

    func filterByTracking(_ term:String?, completion:TweetErrorCompletion?)
    
}
