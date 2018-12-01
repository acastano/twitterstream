import UIKit
import RxSwift
import RxCocoa

final class TweetListViewController: UIViewController {
    
    private let term = "Tennis"
    private var disposeBag = DisposeBag()
    private let identifier = "identifier"
    private let defaultCellHeight = CGFloat(100)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
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
        titleLabel.text = NSLocalizedString("TweetListViewControllerTerm", comment:"") + ": " + term
        reconnectButton.setTitle(NSLocalizedString("TweetListViewControllerReconnect", comment: ""), for: .normal)
    }

    private func loadTerm(_ term:String) {
        disposeBag = DisposeBag()

        streamServices?.filterError.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.tableView.tableFooterView = self?.reconnectView
            }).disposed(by: disposeBag)

        let results = streamServices?.filterByTracking(term)

        results?.bind(to: tableView.rx.items(cellIdentifier: identifier)) { (index, tweet: Tweet, cell) in
            let cell = cell as? TweetViewCell
            cell?.tweet = tweet
            }
            .disposed(by: disposeBag)

        reconnectButton.rx.tap
            .bind { [weak self] in
                self?.tableView.tableFooterView = nil
                self?.loadTerm(term)
            }
            .disposed(by: disposeBag)
    }
}
