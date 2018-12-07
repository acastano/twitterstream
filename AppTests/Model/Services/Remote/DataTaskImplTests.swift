import XCTest
import RxSwift

final class DataTaskImplTests: XCTestCase {
    private let disposeBag = DisposeBag()

    func testNoURLReturnsError() {
        let task = DataTaskImpl(queue: nil, sessionDelegate: SessionDelegate())
        let request = StreamFilterRequestConfigurationNoURL(term: nil)
        var success = false
        task.loadData(request)
            .observeOn(MainScheduler.instance)
            .subscribe(onError: { error in
                let error = error as NSError
                XCTAssert(error.domain == ErrorDomain.dataTask.rawValue)
                success = true
            }).disposed(by: disposeBag)
        XCTAssertTrue(success)
    }

    func testDataTaskWrongProtocol() {
        let task = DataTaskImpl(queue: OperationQueue.main, sessionDelegate: SessionDelegate())
        let request = StreamFilterRequestConfigurationProtocolNotValid(term: nil)

        let expectation = XCTestExpectation(description: "Fail call")

        var success = false

        task.loadData(request)
            .observeOn(MainScheduler.instance)
            .subscribe(onError: { any in
                success = true
                expectation.fulfill()
            }).disposed(by: disposeBag)

        wait(for: [expectation], timeout: 1.0)

        XCTAssertTrue(success)
    }
}
