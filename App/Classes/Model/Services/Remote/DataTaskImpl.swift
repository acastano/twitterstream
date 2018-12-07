import RxSwift
import Foundation

final class DataTaskImpl: DataTask {
    private let queue: OperationQueue?
    private let sessionDelegate: SessionDelegate

    init(queue: OperationQueue?, sessionDelegate: SessionDelegate) {
        self.queue = queue
        self.sessionDelegate = sessionDelegate
    }

    func loadData(_ requestConfiguration: RequestConfiguration) -> Observable<[String : Any]> {

        var dataTask: URLSessionDataTask?

        return Observable<[String : Any]>.create { [weak self] observer in

            self?.sessionDelegate.observer = observer

            if let url = requestConfiguration.url() {
                var urlRequest = URLRequest(url:url)
                urlRequest.timeoutInterval = 0
                urlRequest.httpMethod = requestConfiguration.method().rawValue
                urlRequest.allHTTPHeaderFields = requestConfiguration.headers()

                if let data = requestConfiguration.parameters().data(using: String.Encoding.utf8) {
                    urlRequest.httpBody = data
                }

                let session = URLSession(configuration: .default, delegate: self?.sessionDelegate, delegateQueue: self?.queue)

                dataTask = session.dataTask(with: urlRequest)
                dataTask?.resume()
            } else {
                let error = NSError(domain:ErrorDomain.dataTask.rawValue, code:0, userInfo:nil)
                observer.onError(error)
            }
            return Disposables.create {
                dataTask?.cancel()
                self?.sessionDelegate.observer = nil
            }
        }
    }
}
