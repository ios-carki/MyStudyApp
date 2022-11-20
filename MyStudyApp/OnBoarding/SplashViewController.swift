//
//  SplashViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/17.
//

import UIKit

import FirebaseAuth
import FirebaseCore

final class SplashViewController: UIViewController {
    
    let mainView = SplashView()
    
    let modelView = APIService()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginFunc()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationSetting()
    }
    
    func navigationSetting() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func splashControl() {
        let homeViewController = UINavigationController(rootViewController: MainMapViewController())
        let sesacShopViewController = UINavigationController(rootViewController: MainShopKindViewController())
        let sesacFriendViewController = UINavigationController(rootViewController: MainFriendsViewController())
        let myInfoViewController = UINavigationController(rootViewController: MyInfoViewController())

        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .colorGreen
        tabBarController.setViewControllers([homeViewController, sesacShopViewController, sesacFriendViewController, myInfoViewController], animated: true)

        if let items = tabBarController.tabBar.items {
            items[0].image = UIImage(named: "ic-4")
            items[0].title = "홈"

            items[1].image = UIImage(named: "ic-5")
            items[1].title = "새싹샵"

            items[2].image = UIImage(named: "ic-6")
            items[2].title = "새싹친구"

            items[3].image = UIImage(named: "ic-7")
            items[3].title = "내정보"
        }
        
        let vc = tabBarController

        navigationController?.pushViewController(vc, animated: true)
    }
    
    func getIdToken() {
        
        guard let currentUser = Auth.auth().currentUser else { return }
        currentUser.getIDTokenForcingRefresh(true) { idToken, error in
          if let error = error {
            // Handle error
            return;
          }
            print("갱신성공!❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️")
            print("갱신 id토큰: ", idToken)
            UserDefaults.standard.set(idToken!, forKey: "idtoken")
            
            print("갱신된 id토큰으로 재 로그인 시도")
            self.splashControl()
        }
    }
    
    func loginFunc() {
        modelView.login { (nil, statusCode) in
            
            switch statusCode {
            case 200:
                print("에러코드: ", statusCode)
                print("로그인 성공")
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
//                    self.splashControl()
//                }
                self.splashControl()
            case 401:
                print("에러코드: ", statusCode)
                print("로그인 실패, idtoken 갱신필요")
                self.getIdToken()
            case 406:
                print("에러코드: ", statusCode)
                print("로그인 실패, 미가입유저")
                //Revise: 이럴 경우에도 로그인부터 하라는 요청이 있어야되는건지? / 혹은 앱 처음 시작 분기를 여기서 처리해줘야되는건지?
            case 500:
                print("에러코드: ", statusCode)
                print("로그인 실패, 서버에러 - FCMtoken및 URL 확인 필요")
            case 501:
                print("에러코드: ", statusCode)
                print("로그인 실패, 클라이언트 에러 - API 요청시 Header와 RequestBody에 값을 빠트리지 않고 전송했는지 확인")
            default:
                print("에러코드: ", statusCode)
            }
        }
    }
}
