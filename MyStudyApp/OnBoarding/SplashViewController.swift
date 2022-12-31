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
        
        //loginFunc()
        
        if UserDefaults.standard.string(forKey: "idtoken") == nil {
            self.getIdToken {
                self.loginFunc()
            }
        } else {
            loginFunc()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationSetting()
    }
    
    func getIdToken(completionHandler: @escaping () -> ()) {
        
        guard let currentUser = Auth.auth().currentUser else { return }
        currentUser.getIDTokenForcingRefresh(true) { idToken, error in
          if let error = error {
            // Handle error
              print("Handle error")
            return;
          }
            print("갱신성공!❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️")
            print("갱신 id토큰: ", idToken)
            UserDefaults.standard.set(idToken!, forKey: "idtoken")

            print("갱신된 id토큰으로 재 로그인 시도")
            completionHandler()
        }
        
    }
    
    func navigationSetting() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func oldUserSplashControl() {
        let homeViewController = UINavigationController(rootViewController: MainMapViewController())
        let sesacShopViewController = UINavigationController(rootViewController: ShopTapmanViewController())
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
    
    //[Revise]신규유저: 페이지 뷰컨트롤러에서 뒤에 스플래쉬로 가는 백버튼 없애기
    func newUserSplashControl() {
        let vc = PageViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func getIdTokena() {
        
        guard let currentUser = Auth.auth().currentUser else { return }
        currentUser.getIDTokenForcingRefresh(true) { idToken, error in
          if let error = error {
            // Handle error
            return;
          }
            print("갱신성공!❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️")
            print("갱신 id토큰: ", idToken)
            self.loginFunc()
            UserDefaults.standard.set(idToken!, forKey: "idtoken")
            
            print("갱신된 id토큰으로 재 로그인 시도")
        }
    }
    
    
    func loginFunc() {
        
        modelView.login { (data, statusCode) in
            print("에러코드전 상태 코드: ",statusCode)
            switch statusCode {
            case 200:
                print("상태코드: ", statusCode)
                print("로그인 성공")
                print("idtoken: ", UserDefaults.standard.string(forKey: "idtoken"))
                
                // ⭐️⭐️⭐️ Revise ⭐️⭐️⭐️ 이거 테스트를 위해서 여기다가 해놨음 밑에 유저디폴트
                // 원래 로직대로라면 회원가입 이후에 젠더뷰에서 설정해 놨으니 나중에 완성하면 이부분은 지워야됨
                UserDefaults.standard.set(2, forKey: "matchingStatus")
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.oldUserSplashControl()
                }
                return
            case 401:
                print("에러코드: ", statusCode)
                print("로그인 실패, idtoken 갱신필요")
                self.getIdTokena()
                
                return
            case 406:
                print("에러코드: ", statusCode)
                print("로그인 실패, 미가입유저")
                //Revise: 이럴 경우에도 로그인부터 하라는 요청이 있어야되는건지? / 혹은 앱 처음 시작 분기를 여기서 처리해줘야되는건지?
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.newUserSplashControl()
                }
                //MARK: checkList 두 가지 케이스
                return
            case 500:
                print("에러코드: ", statusCode)
                print("로그인 실패, 서버에러 - FCMtoken및 URL 확인 필요")
                //Revise: FCM토큰 발급, URL 이상함 -> [check] -> 로그인부터?
                
                return
            case 501:
                print("에러코드: ", statusCode)
                print("로그인 실패, 클라이언트 에러 - API 요청시 Header와 RequestBody에 값을 빠트리지 않고 전송했는지 확인")
                //Revise: FCM토큰 발급, URL 이상함 -> [check] -> 로그인부터? / 얼럿 띄워서 앱 종료?
                return
            default:
                print("에러코드: ", statusCode)
                return
            }
        }
    }
}
