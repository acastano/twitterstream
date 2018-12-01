import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate, URLSessionDelegate {
    var window: UIWindow?
    
    func application(_ application:UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = Window(frame:UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = TweetListViewController.controller(StreamServicesFactory.services())
        window?.makeKeyAndVisible()
        var urlRequest = URLRequest(url:URL(string:"url://test.com")!)
        urlRequest.timeoutInterval = 0
        urlRequest.httpMethod = "POST"

        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue.main)

        let dataTask = session.dataTask(with: urlRequest){
            data,response,error in
            print("anything")
        }
        dataTask.resume()
        return true
    }
}

