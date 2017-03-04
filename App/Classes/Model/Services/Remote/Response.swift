
import Foundation

protocol Response {

    var error: NSError? { get }
    
    func populateWithData(_ data:AnyObject?, error:NSError?)
    
}
