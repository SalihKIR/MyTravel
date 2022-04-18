import Foundation
import UIKit

public enum StoryboardNames: String {
    case main = "Main"
    case details = "ShowBoard"
   
}

protocol StoryboardSettings {
    var storyboardName: StoryboardNames { get set }
}

public extension UIViewController {
    
    class func instantiate(storyboard: StoryboardNames = StoryboardNames.main, bundle: Bundle? = nil, identifier: String? = nil) -> Self {
        let viewControllerIdentifier = identifier ?? String(describing: self)
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: bundle)
        guard let viewController = storyboard
            .instantiateViewController(withIdentifier: viewControllerIdentifier) as? Self else {
            preconditionFailure(
                "Unable to instantiate view controller with identifier \(viewControllerIdentifier) as type \(type(of: self))")
        }
        return viewController
    }
}

