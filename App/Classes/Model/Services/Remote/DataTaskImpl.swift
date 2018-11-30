
import Foundation

final class DataTaskImpl: NSObject, DataTask, URLSessionDataDelegate {
    
    private var responseData = NSMutableData()
    private var completion: AnyObjectErrorCompletion?
    
    func loadData(_ url:URL?, method:RequestMethod, headers:[String:String], parameters:String?, timeout:Double, completion:@escaping AnyObjectErrorCompletion) {

        if let url = url {

            self.completion = completion
            
            let session = Foundation.URLSession(configuration: .default, delegate: self, delegateQueue: nil)
            
            
            var mutableRequest = URLRequest(url:url)
            
            mutableRequest.timeoutInterval = timeout

            mutableRequest.httpMethod = method.rawValue
            
            mutableRequest.allHTTPHeaderFields = headers
            
            if let data = parameters?.data(using: String.Encoding.utf8) {

                mutableRequest.httpBody = data
                
            }

            let dataTask = session.dataTask(with: mutableRequest)
            
            dataTask.resume()
            
        } else {

            let error = NSError(domain:ErrorDomain.dataTask.rawValue, code:0, userInfo:nil)
            
            completion(nil, error)
            
        }
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {

        completion?(nil, error as NSError?)
        
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        responseData.length = 0
        
        completionHandler(.allow)
        
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {

        responseData.append(data)

        if let json = parseJSONData (data) {
            
            completion?(json, nil)
            
            responseData.length = 0
            
        }

    }
    
    private func parseJSONData(_ data:Data?) -> AnyObject? {
        
        var responseData: Any?
        
        if let data = data {
            
            do {
                
                responseData = try JSONSerialization.jsonObject(with: data, options:.mutableContainers)
                
            } catch {}
            
        }
        
        return responseData as AnyObject?
        
    }

}
