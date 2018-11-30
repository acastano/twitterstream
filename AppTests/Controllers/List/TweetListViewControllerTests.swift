
import XCTest

class TweetListViewControllerTests: XCTestCase {
    
    private var controller: TweetListViewController?
    
    func testSetup() {
        
        controller = TweetListViewController.controller(StreamServicesSuccessImpl())
        
        controller?.view.layoutIfNeeded()
        
        XCTAssertTrue(controller?.noDataLabel.text == "TweetListViewControllerNoData")
        
        XCTAssertTrue(controller?.titleLabel?.text == "TweetListViewControllerTerm: tennis")
        
        XCTAssertTrue(controller?.retryButton.titleLabel?.text == "TweetListViewControllerRetry")
        
        XCTAssertTrue(controller?.reconnectButton.titleLabel?.text == "TweetListViewControllerReconnect")
        
    }
    
    func testOutletsAreAssigned() {
        
        controller = TweetListViewController.controller(StreamServicesSuccessImpl())
        
        controller?.view.layoutIfNeeded()

        XCTAssertTrue(controller?.noDataView != nil)
        
        XCTAssertTrue(controller?.contentView != nil)
        
        XCTAssertTrue(controller?.titleLabel != nil)
        
        XCTAssertTrue(controller?.noDataLabel != nil)
        
        XCTAssertTrue(controller?.retryButton != nil)
        
        XCTAssertTrue(controller?.reconnectView != nil)
        
        XCTAssertTrue(controller?.tableView != nil)
        
        XCTAssertTrue(controller?.reconnectButton != nil)
        
    }
    
    func testTweetLabelsAreSet() {
        
        controller = TweetListViewController.controller(StreamServicesSuccessImpl())
        
        controller?.view.layoutIfNeeded()
        let cell = controller?.tableView(controller!.tableView, cellForRowAt: IndexPath(row: 0, section: 0))

        XCTAssertTrue(cell is TweetViewCell)
        
        let tweetCell = cell as? TweetViewCell
        
        XCTAssertTrue(tweetCell?.tweetLabel.text == "text")
        XCTAssertTrue(tweetCell?.dateLabel.text == "Fri Jan 02 1970")
        XCTAssertTrue(tweetCell?.userLabel.text == "name / @screen_name")
        
    }
    
    func testDataNotAvailableShowsNoData() {
        
        controller = TweetListViewController.controller(StreamServicesFailureImpl())
        
        controller?.view.layoutIfNeeded()
        
        XCTAssertTrue(controller?.contentView.isHidden == true)
        XCTAssertTrue(controller?.noDataView.isHidden == false)
        
    }
    
    func testRetrySetsViewsAfterNoDataShown() {
        
        controller = TweetListViewController.controller(StreamServicesFailFirstSuccessAfterImpl())
        
        controller?.view.layoutIfNeeded()
        
        XCTAssertTrue(controller?.contentView.isHidden == true)
        XCTAssertTrue(controller?.noDataView.isHidden == false)
        
        controller?.retryTapped(self)
        
        let cell = controller?.tableView(controller!.tableView, cellForRowAt: IndexPath(row: 0, section: 0))

        XCTAssertTrue(cell is TweetViewCell)
        
        let tweetCell = cell as? TweetViewCell
        
        XCTAssertTrue(tweetCell?.tweetLabel.text == "text")
        XCTAssertTrue(tweetCell?.dateLabel.text == "Fri Jan 02 1970")
        XCTAssertTrue(tweetCell?.userLabel.text == "name / @screen_name")

    }

    func testReconnectViewIsNotShowIfNoTweetShown() {
        
        controller = TweetListViewController.controller(StreamServicesFailureImpl())
        
        controller?.view.layoutIfNeeded()
        
        let count = controller?.tableView(controller!.tableView, numberOfRowsInSection: 0) ?? 0
        
        XCTAssertTrue(count == 0)
        
        XCTAssertTrue(controller?.tableView.tableFooterView == nil)
        
    }
    
    func testReconnectViewIsAddedAfterHavingMoreThanOneTweet() {
        
        controller = TweetListViewController.controller(StreamServicesSuccessFirstFailAfterImpl())
        
        controller?.view.layoutIfNeeded()
        
        let count = controller?.tableView(controller!.tableView, numberOfRowsInSection: 0) ?? 0
        
        XCTAssertTrue(count == 1)
        
        controller?.retryTapped(self)
        
        XCTAssertTrue(controller?.tableView.tableFooterView == controller?.reconnectView)
        
    }

    func testRepeatedTweetIsNotAdded() {
        
        controller = TweetListViewController.controller(StreamServicesSuccessImpl())
        
        controller?.view.layoutIfNeeded()

        let count = controller?.tableView(controller!.tableView, numberOfRowsInSection: 0) ?? 0
        
        
        XCTAssertTrue(count == 1)

        controller?.retryTapped(self)
        
        XCTAssertTrue(count == 1)
        
    }
    
    func testMaxTweetEqualToFive() {
        
        controller = TweetListViewController.controller(StreamServicesMultipleSuccessImpl())
        
        controller?.view.layoutIfNeeded()
        
        var count = controller?.tableView(controller!.tableView, numberOfRowsInSection: 0) ?? 0
        
        XCTAssertTrue(count == 1)
        
        controller?.retryTapped(self)
        
        count = controller?.tableView(controller!.tableView, numberOfRowsInSection: 0) ?? 0
        
        XCTAssertTrue(count == 2)
        
        controller?.retryTapped(self)
        
        count = controller?.tableView(controller!.tableView, numberOfRowsInSection: 0) ?? 0
        
        XCTAssertTrue(count == 3)
        
        controller?.retryTapped(self)
        
        count = controller?.tableView(controller!.tableView, numberOfRowsInSection: 0) ?? 0
        
        XCTAssertTrue(count == 4)
        
        controller?.retryTapped(self)
        
        count = controller?.tableView(controller!.tableView, numberOfRowsInSection: 0) ?? 0
        
        XCTAssertTrue(count == 5)
        
        controller?.retryTapped(self)
        
        count = controller?.tableView(controller!.tableView, numberOfRowsInSection: 0) ?? 0

        XCTAssertTrue(count == 5)
        
    }

}
