import RxSwift
import Foundation

protocol StreamServices {
    var filterError: PublishSubject<Error> { get }
    func filterByTracking(_ term:String) -> Observable<[TweetViewModel]>
}
