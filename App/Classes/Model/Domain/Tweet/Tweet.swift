
import Foundation

class Tweet {
    
    let id: NSNumber
    var text: String?
    var name: String?
    var screen_name: String?
    var timestamp_ms: String?
    
    init (id:NSNumber) {
        
        self.id = id
        
    }
    
}