
import Foundation

extension NSObject {

    func runOnMainThread(completion:@escaping VoidCompletion) {
    
        DispatchQueue.main.async(execute: completion)
    
    }

}
