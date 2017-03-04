
import Foundation

typealias AnyObjectErrorCompletion = (AnyObject?, NSError?) -> ()

protocol DataTask {
    
    func loadData(_ url:URL?, method:RequestMethod, headers:[String:String], parameters:String?, timeout:Double, completion:@escaping AnyObjectErrorCompletion)

}
