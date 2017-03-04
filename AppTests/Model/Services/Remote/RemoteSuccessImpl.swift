
import Foundation

class RemoteSuccessImpl: NSObject, Remote {
    
    fileprivate let dataTask: DataTask
    
    required init(dataTask:DataTask, timeout:Double) {
    
        self.dataTask = dataTask
        
    }
    
    func makeRequest(_ request:RequestConfiguration, response:Response, completion:VoidCompletion?) {
        
        dataTask.loadData(nil, method: .POST, headers: [:], parameters: nil, timeout: 0) { data, error in
                    
            response.populateWithData(data, error: error)
            
            completion?()
            
        }
        
    }
    
}
