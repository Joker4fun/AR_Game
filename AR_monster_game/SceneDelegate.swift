//
//  SceneDelegate.swift
//  AR_monster_game
//
//  Created by Антон Казеннов on 14.06.2023.
//

import UIKit

@available(iOS 14.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let defaults = UserDefaults.standard

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
      defaults.set(false, forKey: "startTrue")
      guard let windowScene = (scene as? UIWindowScene) else { return }
     // let mapView = ModelBuilder.createMapView()
      let navigationController = UINavigationController(rootViewController: GeoRequestViewController())
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = navigationController
      self.window = window
      window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
      defaults.set(false, forKey: "starTrue")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

