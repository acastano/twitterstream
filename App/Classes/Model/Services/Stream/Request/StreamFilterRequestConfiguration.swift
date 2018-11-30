
import Foundation

final class StreamFilterRequestConfiguration: RequestConfiguration {
    
    private let term: String?
    private let helper = RequestConfigurationHelper()
    
    init(term:String?) {
        
        self.term = term
    
    }
 
    func url() -> URL? {
        
        let url = helper.url(action(), method: method())
        
        return url
    
    }
    
    func parameters() -> String {
        
        var parameters = ""
        
        if let term = term {
        
            parameters = "\(StreamFilterAttributes.track.rawValue)=\(term)"
            
        }
        
        return parameters
        
    }
    
    func action() -> String {
        
        return StreamActions.filter.rawValue
        
    }
    
    func method() -> RequestMethod {
        
        return .POST
        
    }

    func headers() -> [String : String] {
        
        var dictionary = [String:String]()
        
        dictionary[StreamFilterAttributes.authorization.rawValue] = helper.authorisation(url(), params: parameters())
        
        return dictionary
        
    }
    
}
