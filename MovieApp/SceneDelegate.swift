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

