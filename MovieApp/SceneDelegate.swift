import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = StyleConstants.AppColors.darkGray
        
        let movieListViewController = UINavigationController(rootViewController: MovieListViewController())
        let favouritesViewController = UINavigationController(rootViewController: FavouritesViewController())
        
        movieListViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_app_pressed"))
        favouritesViewController.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(named: "favorites"), selectedImage: UIImage(named: "favorites_app_pressed"))
        
        tabBarController.tabBar.backgroundColor = .white
        
        tabBarController.viewControllers = [movieListViewController, favouritesViewController]
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
    }
}

extension UIApplication {
    
    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        return viewController
    }
    
    class func topNavigationController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UINavigationController? {
        
        if let nav = viewController as? UINavigationController {
            return nav
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return selected.navigationController
            }
        }
        return viewController?.navigationController
    }
}

