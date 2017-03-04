
import Foundation

final class AuthorisationHelper {
    
    class func nonce() -> String {
        
        return NSUUID().uuidString
        
    }
    
    class func timestamp() -> String {
        
        return String(Int(NSDate().timeIntervalSince1970))
        
    }
    
}
