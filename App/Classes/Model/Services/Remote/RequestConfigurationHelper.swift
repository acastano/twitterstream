import Foundation

final class RequestConfigurationHelper {
    private let host: String?
    private let requestProtocol: RequestProtocol?
    
    init() {
        let config = Bundle(for:type(of: self)).object(forInfoDictionaryKey: NetworkConfigurationAttributes.name.rawValue) as? [String:AnyObject]
        host = config?[RequestAttributes.host.rawValue] as? String
        requestProtocol = RequestProtocol(rawValue:config?[RequestAttributes.requestProtocol.rawValue] as? String ?? RequestProtocol.http.rawValue)
    }
    
    func authorisation(_ url:URL?, params:String) -> String {

        let oauth_nonce = AuthorisationHelper.nonce()
        let oauth_timestamp = AuthorisationHelper.timestamp()
        var oauth_signature = ""
        
        let parameters = "\(OAuthKeyAttributes.oauth_consumer_key.rawValue)=\(OAuthAttributes.consumer_key.rawValue)&\(OAuthKeyAttributes.oauth_nonce.rawValue)=\(oauth_nonce)&\(OAuthKeyAttributes.oauth_signature_method.rawValue)=\(OAuthAttributes.signature_method.rawValue)&\(OAuthKeyAttributes.oauth_timestamp.rawValue)=\(oauth_timestamp)&\(OAuthKeyAttributes.oauth_token.rawValue)=\(OAuthAttributes.token.rawValue)&\(OAuthKeyAttributes.oauth_version.rawValue)=\(OAuthAttributes.version.rawValue)&\(params)"
        
        if let encodedURL = url?.absoluteString.urlEncodedStringWithEncoding(), let encodedParameterString = parameters.urlEncodedStringWithEncoding(), let encodedConsumerSecret = OAuthAttributes.consumer_secret.rawValue.urlEncodedStringWithEncoding(), let encodedTokenSecret = OAuthAttributes.token_secret.rawValue.urlEncodedStringWithEncoding() {
            
            let signatureBaseString =  "\(RequestMethod.POST.rawValue)&\(encodedURL)&\(encodedParameterString)"
        
            let signingKey = "\(encodedConsumerSecret)&\(encodedTokenSecret)"

            if let hmac = signatureBaseString.hmac(signingKey), let signature = hmac.base64EncodedString(options:[]).urlEncodedStringWithEncoding() {
                oauth_signature = signature
            }
        }
        
        let auth = "\(OAuthAttributes.oauth.rawValue) \(OAuthKeyAttributes.oauth_consumer_key.rawValue)=\"\(OAuthAttributes.consumer_key.rawValue)\", \(OAuthKeyAttributes.oauth_nonce.rawValue)=\"\(oauth_nonce)\", \(OAuthKeyAttributes.oauth_signature.rawValue)=\"\(oauth_signature)\", \(OAuthKeyAttributes.oauth_signature_method.rawValue)=\"\(OAuthAttributes.signature_method.rawValue)\", \(OAuthKeyAttributes.oauth_timestamp.rawValue)=\"\(oauth_timestamp)\", \(OAuthKeyAttributes.oauth_token.rawValue)=\"\(OAuthAttributes.token.rawValue)\", \(OAuthKeyAttributes.oauth_version.rawValue)=\"\(OAuthAttributes.version.rawValue)\""
        
       return auth
    }
    
    func url(_ action:String, method:RequestMethod) -> URL? {
        var components = URLComponents()
        components.scheme = requestProtocol?.rawValue
        components.host = host
        components.path = "/" + action

        let url = components.url
        return url
    }
}
