import UIKit

public class NavigationController: UINavigationController {
    private var currentViewController: UIViewController?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    private func setup() {
        navigationBar.barTintColor = UIColor(hexString: "1A1A2E")
        navigationBar.tintColor = Colors.secundaryColor
        navigationBar.backgroundColor = Colors.primaryColor
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .black
        navigationBar.shadowImage = UIImage()
        navigationItem.backButtonTitle = ""
        navigationBar.isHidden = true
    }
    
    public func setRootViewController(_ viewController: UIViewController) {
        setViewControllers([viewController], animated: true)
        currentViewController = viewController
        hideBarButtonText()
    }
    
    public func pushViewController(_ viewController: UIViewController) {
        pushViewController(viewController, animated: true)
        currentViewController = viewController
        hideBarButtonText()
    }
    
    func hideBarButtonText() {
        currentViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(customView: UIView())
    }
}
