
import UIKit

let loadingTag = 15435

final class LoadingUtils: NSObject {
    
    class func showLoading(_ view:UIView, message:String) {
        
        if view.viewWithTag(loadingTag) == nil {
            
            let loadingView = loadingLabel(message)
            
           addLoadingView(loadingView, to:view)

        }
        
    }
    
    class func hideLoading(_ view: UIView) {
        
        if let loadingView = view.viewWithTag(loadingTag) {
            
            loadingView.removeFromSuperview()
            
        }
        
    }
    
    fileprivate class func loadingLabel(_ message:String) -> UIView {
    
        let loadingView = UILabel()
    
        loadingView.textAlignment = .center
    
        loadingView.numberOfLines = 0
    
        loadingView.text = message
            
        return loadingView
    
    }
    
    fileprivate class func addLoadingView(_ loadingView:UIView, to view:UIView) {
        
        loadingView.tag = loadingTag
        
        view.addSubview(loadingView)
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(NSLayoutConstraint(item:loadingView, attribute:.centerX, relatedBy:.equal, toItem:view, attribute:.centerX, multiplier:1, constant:0))
        
        view.addConstraint(NSLayoutConstraint(item:loadingView, attribute:.centerY, relatedBy:.equal, toItem:view, attribute:.centerY, multiplier:1, constant:0))
        
        let viewDict = ["loadingView" : loadingView]
        
        let options = NSLayoutFormatOptions.alignAllLeft.rawValue | NSLayoutFormatOptions.alignAllRight.rawValue
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[loadingView]-10-|", options:NSLayoutFormatOptions(rawValue: options), metrics:nil, views:viewDict))
        
        view.layoutIfNeeded()
        
    }
   
}
