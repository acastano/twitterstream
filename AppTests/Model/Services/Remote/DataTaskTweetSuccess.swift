
import Foundation

class DataTaskTweetSuccess: NSObject, DataTask {
    
    func loadData(_ url:URL?, method:RequestMethod, headers:[String:String], parameters:String?, timeout:Double, completion:@escaping AnyObjectErrorCompletion) {
        
        let data = dictionaryFromJSONFile("twitter.json", bundle:Bundle(for: type(of: self)))
        
        completion(data, nil)
        
    }
    
}
