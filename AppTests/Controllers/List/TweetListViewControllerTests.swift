import XCTest
import RxSwift
import RxCocoa

final class TweetListViewControllerTests: XCTestCase {
    
    private var controller: TweetListViewController?
    
    func testSetup() {
        controller = TweetListViewController.controller(StreamServicesSuccessImpl())
        controller?.view.layoutIfNeeded()

        XCTAssertTrue(controller?.titleLabel?.text == "TweetListViewControllerTerm: Tennis")
        XCTAssertTrue(controller?.reconnectButton.titleLabel?.text == "TweetListViewControllerReconnect")
    }
    
    func testOutletsAreAssigned() {
        controller = TweetListViewController.controller(StreamServicesSuccessImpl())
        controller?.view.layoutIfNeeded()

        XCTAssertTrue(controller?.tableView != nil)
        XCTAssertTrue(controller?.titleLabel != nil)
        XCTAssertTrue(controller?.contentView != nil)
        XCTAssertTrue(controller?.reconnectView != nil)
        XCTAssertTrue(controller?.reconnectButton != nil)
    }
    
    func testTweetLabelsAreSet() {
        controller = TweetListViewController.controller(StreamServicesSuccessImpl())

        controller?.view.layoutIfNeeded()
        let cell = controller?.tableView.cellForRow(at: IndexPath(row: 0, section: 0))

        XCTAssertTrue(cell is TweetViewCell)
        let tweetCell = cell as? TweetViewCell

        XCTAssertTrue(tweetCell?.tweetLabel.text == "text")
        XCTAssertTrue(tweetCell?.dateLabel.text == "Fri Jan 02 1970")
        XCTAssertTrue(tweetCell?.userLabel.text == "name / @screen_name")
    }

    func testRetrySetsViewsAfterNoDataShown() {
        controller = TweetListViewController.controller(StreamServicesImpl(dataTask: DataTaskFailureFirstSuccessAfter(), parser: StreamParserImpl()))

        controller?.view.layoutIfNeeded()

        XCTAssertTrue(controller?.tableView.tableFooterView == controller?.reconnectView)

        var cell = controller?.tableView.cellForRow(at: IndexPath(row: 0, section: 0))

        XCTAssertTrue(cell == nil)

        controller?.viewDidLoad()

        cell = controller?.tableView.cellForRow(at: IndexPath(row: 0, section: 0))

        XCTAssertTrue(cell is TweetViewCell)

        let tweetCell = cell as? TweetViewCell

        XCTAssertTrue(tweetCell?.tweetLabel.text == "X just posted this limited service announcement https://t.co/3S98Iq5TWJ")
        XCTAssertTrue(tweetCell?.dateLabel.text == "Fri Jun 24 2016")
        XCTAssertTrue(tweetCell?.userLabel.text == "Rhys Southan / @rhyssouthan")
    }

    func testReconnectViewIsShowWhenError() {
        controller = TweetListViewController.controller(StreamServicesImpl(dataTask: DataTaskFailure(), parser: StreamParserImpl()))
        controller?.view.layoutIfNeeded()
        
        XCTAssertTrue(controller?.tableView.tableFooterView == controller?.reconnectView)
    }

    func testReconnectViewIsAddedAfterHavingMoreThanOneTweet() {
        controller = TweetListViewController.controller(StreamServicesImpl(dataTask: DataTaskFirstSuccessFailureAfter(), parser: StreamParserImpl()))
        controller?.view.layoutIfNeeded()

        let count = controller?.tableView.numberOfRows(inSection: 0)

        XCTAssertTrue(count == 1)
        XCTAssertTrue(controller?.tableView.tableFooterView == nil)

        controller?.viewDidLoad()

        XCTAssertTrue(controller?.tableView.tableFooterView == controller?.reconnectView)
    }

    func testRepeatedTweetIsNotAdded() {
        controller = TweetListViewController.controller(StreamServicesImpl(dataTask: DataTaskTweetSuccess(), parser: StreamParserImpl()))
        controller?.view.layoutIfNeeded()

        let count = controller?.tableView.numberOfRows(inSection: 0)
        XCTAssertTrue(count == 1)

        controller?.viewDidLoad()
        XCTAssertTrue(count == 1)
    }

    func testMaxTweetsEqualToFive() {
        controller = TweetListViewController.controller(StreamServicesImpl(dataTask: DataTaskMultipleSuccess(), parser: StreamParserImpl()))
        controller?.view.layoutIfNeeded()

        var count = controller?.tableView.numberOfRows(inSection: 0) ?? 0
        XCTAssertTrue(count == 1)

        controller?.viewDidLoad()
        count = controller?.tableView.numberOfRows(inSection: 0) ?? 0
        XCTAssertTrue(count == 2)

        controller?.viewDidLoad()
        count = controller?.tableView.numberOfRows(inSection: 0) ?? 0
        XCTAssertTrue(count == 3)

        controller?.viewDidLoad()
        count = controller?.tableView.numberOfRows(inSection: 0) ?? 0
        XCTAssertTrue(count == 4)

        controller?.viewDidLoad()
        count = controller?.tableView.numberOfRows(inSection: 0) ?? 0

        controller?.viewDidLoad()
        count = controller?.tableView.numberOfRows(inSection: 0) ?? 0
        XCTAssertTrue(count == 5)

        controller?.viewDidLoad()
        count = controller?.tableView.numberOfRows(inSection: 0) ?? 0
        XCTAssertTrue(count == 5)
    }
}
