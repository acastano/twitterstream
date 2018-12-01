import RxSwift
import Foundation

final class StreamServicesImpl: StreamServices {
    let filterError = PublishSubject<Error>()
    private var disposeBag = DisposeBag()
    private let tweetsSubject = BehaviorSubject<[Tweet]>(value: [])

    private let dataTask: DataTask
    private let parser: StreamParser

    init (dataTask: DataTask) {
        self.dataTask = dataTask

        parser = StreamParserImpl()
    }

    func filterByTracking(_ term: String) -> Observable<[Tweet]> {
        disposeBag = DisposeBag()

        let requestConfiguration = StreamFilterRequestConfiguration(term:term)

        let observable: Observable<Tweet> = dataTask.loadData(requestConfiguration).map { [weak self] jsonData in
            guard let response = try self?.parser.process(json: jsonData) else {
                throw NSError(domain:ErrorDomain.error.rawValue, code:0, userInfo:nil)
            }
            return response
        }

        observable.subscribe(onNext: { [weak self] tweet in
            self?.processTweet(tweet)
            }, onError: { [weak self] error in
            self?.filterError.onNext(error)
        }).disposed(by: disposeBag)

        return tweetsSubject.asObservable()
    }

    private func processTweet(_ tweet: (Tweet)) {
        if var tweets = try? tweetsSubject.value() {
            let filter = tweets.filter() { $0.id == tweet.id }
            if filter.count == 0 {
                tweets.insert(tweet, at: 0)
                if tweets.count > 5 {
                    tweets.removeLast()
                }
                tweetsSubject.on(.next(tweets))
            }
        }
    }
}
