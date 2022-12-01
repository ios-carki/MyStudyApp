//
//  GenderViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/09.
//

import UIKit

import FirebaseCore
import FirebaseAuth
import FirebaseMessaging

final class GenderViewController: UIViewController {
    
    let mainView = GenderView()
    
    let modelView = APIService()
    
    
    //manView, womanView에 텝 제스쳐 줄것
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = User.shared
        print(user.email ?? "")
        backGroundViewSetting()
        viewSetting()
        nextButtonSetting()
    }
    
    //이거 쓰면 모든 뷰객체 선택때마다 실행됨
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        print("배경 선택됨")
//        mainView.manView.backgroundColor = .white
//        mainView.womanView.backgroundColor = .white
//        mainView.nextButton.backgroundColor = .colorGray6
//
//        gender.gender = -1
//    }
    func backGroundViewSetting() {
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(backGroundTapped))
        mainView.backGroundView.addGestureRecognizer(backTapGesture)
    }
    
    @objc func backGroundTapped() {
        print("백그라운드 탭됨")
        
        //UPDATE: 유저데이터 빠른 확인을위해 유저디폴트 사용 -> 나중에 삭제 후 구조체 직접 대입으로 바꾸기
//        UserDefaults.standard.set(-1, forKey: "gender")
//        print("저장된 성별 데이터: ", UserDefaults.standard.integer(forKey: "gender"))
        let user = User.shared
        user.gender = -1
        
        mainView.manView.backgroundColor = .white
        mainView.womanView.backgroundColor = .white
        mainView.nextButton.backgroundColor = .colorGray6
    }
    
    func viewSetting() {
        let manViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(manViewTapped))
        let womanViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(womanViewTapped))
        
        mainView.manView.addGestureRecognizer(manViewTapGesture)
        mainView.womanView.addGestureRecognizer(womanViewTapGesture)
    }
    
    func nextButtonSetting() {
        mainView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    @objc func nextButtonClicked() {
        let user = User.shared
        //var genderData = UserDefaults.standard.integer(forKey: "gender")
        
        if user.gender == 0 || user.gender == 1 {
            print("성별데이터 있음")
            print("현재 idtoken: ", UserDefaults.standard.string(forKey: "idtoken"))
            
            modelView.signup(phoneNum: user.phoneNumber ?? "", FCMToken: UserDefaults.standard.string(forKey: "firebaseToken") ?? "", nickName: user.nick ?? "", birth: user.birth ?? "", email: user.email ?? "", gender: String(user.gender ?? -1)) { statusCode in
                
                
                switch statusCode {
                case 200:
                    let nextViewAction = UIAlertAction(title: "시작하기", style: .default) { action in
                        self.appStart()
                    }
                    self.oneButtonAlert(alertTitle: "회원가입 완료!", alertMessage: "이제부터 새싹 서비스를 이용할 수 있습니다.", alertStyle: .alert, actions: nextViewAction)
                    return
                case 201:
                    return self.customAlert(alertTitle: "회원가입 실패", alertMessage: "이미 가입한 유저입니다.", alertStyle: .alert)
                case 202:
                    return self.customAlert(alertTitle: "회원가입 실패", alertMessage: "사용할 수 없는 닉네임 입니다.", alertStyle: .alert)
                case 401:
                    return self.customAlert(alertTitle: "회원가입 실패", alertMessage: "만료된 토큰입니다.", alertStyle: .alert)
                case 406:
                    return self.customAlert(alertTitle: "회원가입 실패", alertMessage: "미가입 회원입니다.", alertStyle: .alert)
                case 500:
                    return self.customAlert(alertTitle: "회원가입 실패", alertMessage: "서버에러", alertStyle: .alert)
                case 501:
                    return self.customAlert(alertTitle: "회원가입 실패", alertMessage: "인터넷연결확인", alertStyle: .alert)
                default:
                    return print("anjwl")
                }
            }
            
        } else {
            print("성별데이터 없음")
            view.makeToast("성별을 선택해주세요.", position: .top)
        }
    }
    
    @objc func manViewTapped() {
        mainView.manView.backgroundColor = .colorWhiteGreen
        mainView.womanView.backgroundColor = .white
        mainView.nextButton.backgroundColor = .colorGreen
        
        //var gender: User = User()
        //UPDATE: 유저데이터 빠른 확인을위해 유저디폴트 사용 -> 나중에 삭제 후 구조체 직접 대입으로 바꾸기
//        UserDefaults.standard.set(1, forKey: "gender")
//        print("저장된 성별 데이터: ", UserDefaults.standard.integer(forKey: "gender"))
        
        let user = User.shared
        user.gender = 1
    }
    
    @objc func womanViewTapped() {
        mainView.manView.backgroundColor = .white
        mainView.womanView.backgroundColor = .colorWhiteGreen
        mainView.nextButton.backgroundColor = .colorGreen
        
        //var gender: User = User()
        //UPDATE: 유저데이터 빠른 확인을위해 유저디폴트 사용 -> 나중에 삭제 후 구조체 직접 대입으로 바꾸기
//        UserDefaults.standard.set(0, forKey: "gender")
//        print("저장된 성별 데이터: ", UserDefaults.standard.integer(forKey: "gender"))
        
        let user = User.shared
        user.gender = 0
    }
    
    func appStart() {
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
        // ⭐️⭐️⭐️ Revise ⭐️⭐️⭐️ 이거 테스트를 위해서 스플래쉬 뷰컨에도 있음 스플레쉬 뷰컨에 있는거 지워야됨
        UserDefaults.standard.set(0, forKey: "matchingStatus")
        navigationController?.pushViewController(vc, animated: true)
    }
}
