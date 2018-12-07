import Foundation

final class StreamServicesFactory {
    class func services() -> StreamServices {
        let services = StreamServicesImpl(dataTask: DataTaskImpl(queue: nil, sessionDelegate: SessionDelegate()), parser: StreamParserImpl())
        return services
    }
}
