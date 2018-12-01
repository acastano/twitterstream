import XCTest
import RxSwift

final class SessionDelegateTests: XCTestCase {
    private let disposeBag = DisposeBag()
    private let sessionDelegate = SessionDelegate()

    func testError() {
        let publishSubject = PublishSubject<[String: Any]>()
        sessionDelegate.observer = publishSubject.asObserver()

        var success = false
        publishSubject.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onError: { error in
                let error = error as NSError
                XCTAssert(error.domain == ErrorDomain.dataTask.rawValue)
                success = true
            }).disposed(by: disposeBag)
        let error = NSError(domain:ErrorDomain.dataTask.rawValue, code:0, userInfo:nil)

        sessionDelegate.urlSession(URLSession.shared, task: URLSessionTask(), didCompleteWithError: error)
        XCTAssertTrue(success)
    }

    func testDataReceive() {
        let publishSubject = PublishSubject<[String: Any]>()
        sessionDelegate.observer = publishSubject.asObserver()

        var success = false
        publishSubject.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { any in
                success = true
            }).disposed(by: disposeBag)

        let data = dataFromJSONFile("twitter.json", bundle:Bundle(for: type(of:self))) ?? Data()
        sessionDelegate.urlSession(URLSession.shared, dataTask: URLSessionDataTask(), didReceive: data)
        XCTAssertTrue(success)
    }

    func testCompletionToAllow() {
        var success = false
        sessionDelegate.urlSession(URLSession.shared, dataTask: URLSessionDataTask(), didReceive: URLResponse()) { responseDisposition in
            success = responseDisposition == .allow
        }
        XCTAssertTrue(success)
    }
}
