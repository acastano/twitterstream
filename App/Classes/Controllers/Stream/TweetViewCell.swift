import UIKit

final class TweetViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!

    var tweet: Tweet? {
        didSet {
            setup()
        }
    }
    
    private func setup() {
        userLabel.text = nil
        
        if let screen_name = tweet?.screen_name, let user = tweet?.name {
            userLabel.text = "\(user) / @\(screen_name)"
        }
        
        tweetLabel.text = tweet?.text
        dateLabel.text = tweet?.timestamp_ms?.cccMMMddYYYY()
    }
}
