import Foundation

final class StreamFilterRequestConfigurationProtocolNotValid: RequestConfiguration {
    
    private let term: String?
    
    init(term:String?) {
        self.term = term
    }

    func url() -> URL? {
        return URL(string:"protocol://url.com")
    }
    
    func parameters() -> String {
        return ""
    }
    
    func action() -> String {
        return StreamActions.filter.rawValue
    }
    
    func method() -> RequestMethod {
        return .POST
    }

    func headers() -> [String : String] {
        return [:]
    }
}
