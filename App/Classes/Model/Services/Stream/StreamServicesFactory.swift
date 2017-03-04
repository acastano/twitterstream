
import Foundation

final class StreamServicesFactory {
    
    class func services() -> StreamServices {
        
        let remote = RemoteImpl(dataTask: DataTaskImpl(), timeout: 30)
        
        let services = StreamServicesImpl(remote: remote)

        return services
        
    }
    
}