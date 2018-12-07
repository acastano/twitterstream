import RxSwift
import Foundation

protocol DataTask {
    func loadData(_ requestConfiguration: RequestConfiguration) -> Observable<[String : Any]>
}
