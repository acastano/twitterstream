import RxSwift
import Foundation

final class DataTaskTweetSuccess: NSObject, DataTask {
    
    func loadData(_ requestConfiguration: RequestConfiguration) -> Observable<[String : Any]> {
        return Observable<[String : Any]>.create { observer in
            let data = self.dictionaryFromJSONFile("twitter.json", bundle:Bundle(for: type(of: self)))
            observer.onNext(data ?? [:])
            return Disposables.create {}
        }
    }
}
