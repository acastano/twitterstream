
import Foundation

class DataTaskFailure: DataTask {
    
    func loadData(_ url:URL?, method:RequestMethod, headers:[String:String], parameters:String?, timeout:Double, completion:@escaping AnyObjectErrorCompletion) {
    
        let error = NSError(domain: "error", code: 1, userInfo: nil)
        
        completion(nil, error)
        
    }
    
}
