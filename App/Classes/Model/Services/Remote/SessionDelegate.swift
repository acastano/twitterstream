import RxSwift
import Foundation

final class SessionDelegate: NSObject, URLSessionDataDelegate {
    var observer: AnyObserver<[String: Any]>?
    private var responseData = NSMutableData()

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            observer?.onError(error)
        }
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        responseData.length = 0
        completionHandler(.allow)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        responseData.append(data)
        if let json = parseJSONData (data) {
            observer?.onNext(json)
            responseData.length = 0
        }
    }

    private func parseJSONData(_ data:Data?) -> [String : Any]? {
        var responseData: [String: Any]?
        if let data = data {
            do {
                responseData = try JSONSerialization.jsonObject(with: data, options:.mutableContainers) as? [String : Any]
            } catch {}
        }
        return responseData
    }
}
