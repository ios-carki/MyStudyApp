//
//  SceneDelegate.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/07.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let vc = SplashViewController()
        let nav = UINavigationController(rootViewController: vc)
        
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        

//        let homeViewController = UINavigationController(rootViewController: MainMapViewController())
//        let sesacShopViewController = UINavigationController(rootViewController: MainShopKindViewController())
//        let sesacFriendViewController = UINavigationController(rootViewController: MainFriendsViewController())
//        let myInfoViewController = UINavigationController(rootViewController: MyInfoViewController())
//
//        let tabBarController = UITabBarController()
//        tabBarController.tabBar.tintColor = .colorGreen
//        tabBarController.setViewControllers([homeViewController, sesacShopViewController, sesacFriendViewController, myInfoViewController], animated: true)
//
//        if let items = tabBarController.tabBar.items {
//            items[0].image = UIImage(named: "ic-4")
//            items[0].title = "홈"
//
//            items[1].image = UIImage(named: "ic-5")
//            items[1].title = "새싹샵"
//
//            items[2].image = UIImage(named: "ic-6")
//            items[2].title = "새싹친구"
//
//            items[3].image = UIImage(named: "ic-7")
//            items[3].title = "내정보"
//        }
////
////        let vc = MainMapViewController()
////
////        window?.rootViewController = tabBarController
////        window?.makeKeyAndVisible()

        //MARK: 메인 시작
//        if UserDefaults.standard.bool(forKey: "oldUser") {
//            let vc = tabBarController
//
//            window?.rootViewController = vc
//        } else {
//            let vc = SplashViewController()
//            let nav = UINavigationController(rootViewController: vc)
//
//            window?.rootViewController = nav
//        }
//        window?.makeKeyAndVisible()
//
//        let vc = SplashViewController()
//        let nav = UINavigationController(rootViewController: vc)
//
//        window?.rootViewController = nav
//        window?.makeKeyAndVisible()
        
        //let vc = MainMapViewController()
        
        
        //MARK: 뷰별로 테스트
        
//        let vc = tabBarController
//        //let nav = UINavigationController(rootViewController: vc)
//
//        window?.rootViewController = vc
//        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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
    }


}

