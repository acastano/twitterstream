
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application:UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplicationLaunchOptionsKey: Any]?) -> Bool {
                
        window = Window(frame:UIScreen.main.bounds)
        
        window?.backgroundColor = UIColor.white

        window?.rootViewController = TweetListViewController.controller(StreamServicesFactory.services())
        
        window?.makeKeyAndVisible()

        return true
        
    }
    
}

