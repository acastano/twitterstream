import RxSwift
import Foundation

final class DataTaskFailure: DataTask {
    private var calls = 0

    func loadData(_ requestConfiguration: RequestConfiguration) -> Observable<[String : Any]> {
        let error = NSError(domain: "error", code: 1, userInfo: nil)
        
        let observable = Observable<[String : Any]>.create { observer in
            observer.onError(error)
            return Disposables.create {}
        }
        return observable
    }
}
