
import Foundation

extension NSObject {
    
    class func shortClassName() -> String {
        
        let name = String(describing: self)
        
        return name
        
    }
    
    func dictionaryFromJSONFile(_ name:String, bundle:Bundle) -> AnyObject? {
        
        var responseData: Any?
        
        let path = bundle.url(forResource: name, withExtension:nil)
        
        if let path = path, let data = try? Data(contentsOf: path) {
            
            do {
                
                responseData = try JSONSerialization.jsonObject(with: data, options:.mutableContainers)
                
            } catch {}
            
        }
        
        return  responseData as AnyObject?
        
    }
    
}
        
