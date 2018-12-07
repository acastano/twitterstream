import Foundation

struct TweetViewModel {
    let id: Int
    let userText: String?
    let dateText: String?
    let tweetText: String?

    init(tweet: Tweet) {
        id = tweet.id
        if let screen_name = tweet.screen_name, let user = tweet.name {
            userText = "\(user) / @\(screen_name)"
        } else {
            userText = nil
        }

        tweetText = tweet.text
        dateText = tweet.timestamp_ms?.cccMMMddYYYY()
    }
}
