
import Foundation

protocol RequestConfiguration {
    
    func url() -> URL?
    func action() -> String
    func parameters() -> String
    func method() -> RequestMethod
    func headers() -> [String:String]
    
}
