//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by Jurica Mikulic on 22.03.2022..
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window!.rootViewController = MovieDetailsViewController()
        //window!.rootViewController = MovieListViewController()
        window?.makeKeyAndVisible()
    }
}

