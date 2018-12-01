import RxSwift
import Foundation

final class DataTaskMultipleSuccess: NSObject, DataTask {
    private var calls = 0

    func loadData(_ requestConfiguration: RequestConfiguration) -> Observable<[String : Any]> {
        let observable = Observable<[String : Any]>.create { observer in
            var data = self.dictionaryFromJSONFile("twitter.json", bundle:Bundle(for: type(of: self))) ?? [:]
            data[TweetAttributes.id.rawValue] = self.calls
            observer.onNext(data)

            self.calls = self.calls + 1
            return Disposables.create {}
        }
        return observable
    }
}
