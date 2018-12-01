import RxSwift
import Foundation

final class StreamServicesMultipleSuccessImpl: StreamServices {

    private var calls = 0

    var filterError: PublishSubject<Error> { return PublishSubject() }
    func filterByTracking(_ term:String) -> Observable<[Tweet]> {

        return Observable.create({ anyObserver in
            if self.calls > 0 {
                let error = NSError(domain: "", code:0, userInfo: nil)
                anyObserver.onError(error)
            } else {
                anyObserver.onNext([self.tweet(self.calls)])
            }

            self.calls = self.calls + 1
            return Disposables.create {}
        })
    }

    private func tweet(_ id:Int) -> Tweet {
        let instance = Tweet(id: id, text: "text", name: "name", screen_name: "screen_name", timestamp_ms: "134567890")
        return instance
    }
}
