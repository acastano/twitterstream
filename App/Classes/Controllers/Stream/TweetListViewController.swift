
import UIKit

final class TweetListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var tweets = [Tweet]()
    private let term = "tennis"
    private let identifier = "identifier"
    private let defaultCellHeight = CGFloat(100)
    
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var reconnectView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var reconnectButton: UIButton!
    
    private var streamServices: StreamServices?
    
    class func controller(_ streamServices: StreamServices) -> TweetListViewController? {
    
        let controller = UIStoryboard.instantiateViewController(shortClassName(), anyClass:self) as? TweetListViewController
    
        controller?.streamServices = streamServices
        
        return controller
    
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setup()
        
        loadTerm(term)
        
    }
    
    //MARK: - Helpers

    private func setup() {
        
        tableView.estimatedRowHeight = defaultCellHeight
        
        tableView.rowHeight = UITableViewAutomaticDimension

        noDataLabel.text = NSLocalizedString("TweetListViewControllerNoData", comment: "")
        
        titleLabel.text = NSLocalizedString("TweetListViewControllerTerm", comment:"") + ": " + term
        
        retryButton.setTitle(NSLocalizedString("TweetListViewControllerRetry", comment: ""), for: UIControlState())
        
        reconnectButton.setTitle(NSLocalizedString("TweetListViewControllerReconnect", comment: ""), for: UIControlState())
        
    }
    
    private func showLoading() {
        
        if tweets.count == 0 {
            
            contentView.isHidden = true
            
            noDataView.isHidden = true
            
            LoadingUtils.showLoading(view, message: NSLocalizedString("LoadingUtilsLoading", comment:""))
            
        }
        
        tableView.tableFooterView = nil

    }
    
    private func loadTerm(_ term:String?) {

        showLoading()
        
        streamServices?.filterByTracking(term) { [weak self] tweet, error in
            
            if let instance = self {
                
                instance.process(tweet, error: error)
                
            }
            
        }
        
    }
    
    private func process(_ tweet:Tweet?, error:NSError?) {
        
        LoadingUtils.hideLoading(view)

        contentView.isHidden = error != nil && tweets.count == 0
        
        noDataView.isHidden = contentView.isHidden == false
        
        if let tweet = tweet {
            
            let filter = tweets.filter() { $0.id == tweet.id }
                        
            if filter.count == 0 {
                
                tweets.insert(tweet, at: 0)
                
                if tweets.count > 5 {
                    
                    tweets.removeLast()
                    
                }
                
                tableView.reloadData()
                
            }
            
        }
        
        if error != nil && tweets.count > 0 {
            
            tableView.tableFooterView = reconnectView
            
        }
        
    }
    
    //MARK: - Actions
    
    @IBAction func retryTapped(_ sender:AnyObject) {
        
       loadTerm(term)
        
    }
    
    //MARK: - UITableView Source/Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = tweets.count
        
        return count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for:indexPath) as? TweetViewCell
        
        cell?.tweet = tweets[indexPath.row]
        
        return cell!
        
    }

}
