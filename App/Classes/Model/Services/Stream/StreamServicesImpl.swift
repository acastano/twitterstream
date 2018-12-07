import RxSwift
import Foundation

final class StreamServicesImpl: StreamServices {
    let filterError = PublishSubject<Error>()
    private var disposeBag = DisposeBag()
    private let tweetsSubject = BehaviorSubject<[TweetViewModel]>(value: [])

    private let dataTask: DataTask
    private let parser: StreamParser

    init (dataTask: DataTask, parser: StreamParser) {
        self.dataTask = dataTask
        self.parser = parser
    }

    func filterByTracking(_ term: String) -> Observable<[TweetViewModel]> {
        disposeBag = DisposeBag()

        let requestConfiguration = StreamFilterRequestConfiguration(term:term)

        let observable: Observable<Tweet> = dataTask.loadData(requestConfiguration).map { [weak self] jsonData in
            guard let response = try self?.parser.process(json: jsonData) else {
                throw NSError(domain:ErrorDomain.error.rawValue, code:0, userInfo:nil)
            }
            return response
        }

        observable.map(TweetViewModel.init).subscribe(onNext: { [weak self] tweet in
            self?.processTweet(tweet)
            }, onError: { [weak self] error in
            self?.filterError.onNext(error)
        }).disposed(by: disposeBag)

        return tweetsSubject.asObservable()
    }

    private func processTweet(_ viewModel: TweetViewModel) {
        if var tweets = try? tweetsSubject.value() {
            let filter = tweets.filter() { $0.id == viewModel.id }
            if filter.count == 0 {
                tweets.insert(viewModel, at: 0)
                if tweets.count > 5 {
                    tweets.removeLast()
                }
                tweetsSubject.on(.next(tweets))
            }
        }
    }
}
