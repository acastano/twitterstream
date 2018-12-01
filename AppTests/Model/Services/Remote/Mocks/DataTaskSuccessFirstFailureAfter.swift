import RxSwift
import Foundation

final class DataTaskFirstSuccessFailureAfter: NSObject, DataTask {
    private var calls = 0

    func loadData(_ requestConfiguration: RequestConfiguration) -> Observable<[String : Any]> {
        let observable = Observable<[String : Any]>.create { observer in
            if self.calls > 0 {
                let error = NSError(domain: "", code:0, userInfo: nil)
                observer.onError(error)
            } else {
                let data = self.dictionaryFromJSONFile("twitter.json", bundle:Bundle(for: type(of: self)))
                observer.onNext(data ?? [:])
            }
            self.calls = self.calls + 1
            return Disposables.create {}
        }
        return observable
    }
}
