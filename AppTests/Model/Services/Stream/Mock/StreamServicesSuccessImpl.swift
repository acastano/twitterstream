import RxSwift
import Foundation

final class StreamServicesSuccessImpl: StreamServices {
    var filterError: PublishSubject<Error> { return PublishSubject() }

    func filterByTracking(_ term:String) -> Observable<[Tweet]> {
        return Observable.just([tweet()])
    }
    
    private func tweet() -> Tweet {
        let instance = Tweet(id: 1, text: "text", name: "name", screen_name: "screen_name", timestamp_ms: "134567890")
        return instance
    }
}
