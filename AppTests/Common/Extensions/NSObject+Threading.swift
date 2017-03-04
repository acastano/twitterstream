
import Foundation

extension NSObject {

    func runOnMainThread(_ completion:VoidCompletion) {
    
        completion()
    
    }

}
