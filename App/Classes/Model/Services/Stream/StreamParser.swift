
import Foundation

protocol StreamParser {
    
    func process(_ id: NSNumber, json: [String : AnyObject]) -> Tweet
    
}
