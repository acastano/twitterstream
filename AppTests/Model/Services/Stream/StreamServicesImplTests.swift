import XCTest
import RxSwift

final class StreamServicesImplTests: XCTestCase {
    private let disposeBag = DisposeBag()

    func testTermSuccess() {
        let services = StreamServicesImpl(dataTask: DataTaskTweetSuccess(), parser: StreamParserImpl())

        var success = false
        services.filterByTracking("")
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { tweet in
                XCTAssert(tweet.count == 1)
                success = true
            }).disposed(by: disposeBag)
        XCTAssertTrue(success)
    }
    
    func testTermFailure() {
        let services = StreamServicesImpl(dataTask: DataTaskFailure(), parser: StreamParserImpl())

        var success = false
        services.filterError.observeOn(MainScheduler.instance)
            .subscribe(onNext: { error in
                success = true
            }).disposed(by: disposeBag)

        services.filterByTracking("")
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { tweet in
                XCTAssert(tweet.count == 0)
            }).disposed(by: disposeBag)
        XCTAssertTrue(success)
    }

    func testTermCorrupted() {
        let services = StreamServicesImpl(dataTask: DataTaskTweetSuccessButCorrupted(), parser: StreamParserImpl())

        var success = false
        services.filterError.observeOn(MainScheduler.instance)
            .subscribe(onNext: { error in
                success = true
            }).disposed(by: disposeBag)

        services.filterByTracking("")
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { tweet in
                XCTAssert(tweet.count == 0)
            }).disposed(by: disposeBag)
        XCTAssertTrue(success)
    }
}
