
import Foundation

protocol Remote {
    
    init(dataTask:DataTask, timeout:Double)
    func makeRequest(_ request:RequestConfiguration, response:Response, completion:VoidCompletion?)
   
}
