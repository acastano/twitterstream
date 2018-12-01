import Foundation

protocol StreamParser {
    func process(json: [String : Any]) throws -> Tweet
}
