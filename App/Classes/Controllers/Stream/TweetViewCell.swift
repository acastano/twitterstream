import UIKit

final class TweetViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!


    func configure(_ viewModel: TweetViewModel) {
        userLabel.text = viewModel.userText
        dateLabel.text = viewModel.dateText
        tweetLabel.text = viewModel.tweetText
    }
}
