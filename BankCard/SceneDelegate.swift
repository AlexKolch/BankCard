//
//  SceneDelegate.swift
//  BankCard
//
//  Created by Алексей Колыченков on 29.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let winScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: winScene)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }

}

