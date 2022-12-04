//
//  RequestPopupViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/03.
//

import UIKit

import Toast

final class RequestPopupViewController: UIViewController {
    private let mainView = MyInfoWithdrawView()
    private let modelView = APIService()
    
    //상대방 uid
    var userUID: String? = nil
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetting()
        buttonSetting()
    }
    
    func viewSetting() {
        mainView.signLabel.text = "스터디를 수락할까요?"
        mainView.messageLabel.text = "요청을 수락하면 채팅창에서 대화를 나눌 수 있어요"
    }
    
    func buttonSetting() {
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        
        mainView.okButton.addTarget(self, action: #selector(okButtonClikced), for: .touchUpInside)
    }
    
    @objc func cancelButtonClicked() {
        self.dismiss(animated: false)
    }
    
    //MARK: 스터디 수락하기 버튼
    @objc func okButtonClikced() {
        print("넘어온 유저 UID: \(userUID)")
        
        //Revise: 테스트 용으로 유저디폴트 이후 완성되면 값전달로 전환할 로직
        UserDefaults.standard.set(userUID, forKey: "userUID")
        acceptStudy(userUID: userUID ?? "")
    }
    
    func acceptStudy(userUID: String) {
        modelView.acceptStudy(otherUID: userUID) { statusCode in
            switch statusCode {
            case 200:
                print("스터디 요청 수락! ✅✅✅✅✅")
                
                //MARK: 채팅 수락 후 화면전환시 확인할 코드⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️
                //Revise: 채팅 수락하고 화면전환 안되면 이곳 확인
                //사용자 현재 상태를 매칭상태로 변경 후 팝업 Dismiss
                UserDefaults.standard.set(1, forKey: "matchingStatus")
                
                self.navigationController?.dismiss(animated: false) {
                    let pvc = RequestSeSACViewController()
                    
                    pvc.navigationController?.pushViewController(ChattingViewController(), animated: true)
                }
                
                //채팅뷰 이동 코드
                
                return
            case 201:
                print("상대방이 이미 다른 사용자와 매칭된 상태 ✅✅✅✅✅")
                self.dismiss(animated: false)
                RequestSeSACViewController().view.makeToast("상대방이 이미 다른 새싹과 스터디를 함께 하는 중입니다.")
                
                return
            case 202:
                print("상대방이 새싹 찾기를 중단한 상태 ✅✅✅✅✅")
                self.dismiss(animated: false)
                RequestSeSACViewController().view.makeToast("상대방이 스터디 찾기를 그만두었습니다.")
                
                return
            case 203:
                print("내가 이미 다른 사용자와 매칭된 상태 ✅✅✅✅✅")
                self.dismiss(animated: false)
                RequestSeSACViewController().view.makeToast("앗! 누군가가 나의 스터디를 수락하였어요!")
                //myqueueState 호출
                
                return
            case 401:
                print("idToken에러 ❌❌❌❌❌")
                
                return
            case 406:
                print("미가입 회원 ❌❌❌❌❌")
                
                return
            case 500:
                print("서버에러")
                
                return
            case 501:
                print("클라이언트 에러")
                
                return
            default:
                print("default ❌")
            }
        }
    }
}

