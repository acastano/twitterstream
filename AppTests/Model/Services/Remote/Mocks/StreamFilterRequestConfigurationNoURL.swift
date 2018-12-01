import Foundation

final class StreamFilterRequestConfigurationNoURL: RequestConfiguration {
    
    private let term: String?
    
    init(term:String?) {
        self.term = term
    }

    func url() -> URL? {
        return nil
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
