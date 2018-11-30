
import Foundation

final class RemoteImpl: NSObject, Remote {
    
    private let timeout: Double
    private let dataTask: DataTask
    
    required init(dataTask:DataTask, timeout:Double) {
        
        self.timeout = timeout
        
        self.dataTask = dataTask
        
    }
    
    func makeRequest(_ request:RequestConfiguration, response:Response, completion:VoidCompletion?) {
                
        dataTask.loadData(request.url(), method: request.method(), headers: request.headers(), parameters: request.parameters(), timeout:timeout) { json, error in
            
            response.populateWithData(json, error:error)
            
            self.runOnMainThread() {
                
                completion?()
                
            }

        }
        
    }
    
}
