//
//  NearUserPopupViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/29.
//
import UIKit

import Toast

final class NearUserPopupViewController: UIViewController {
    private let mainView = MyInfoWithdrawView()
    private let modelView = APIService()
    
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
        mainView.signLabel.text = "스터디를 요청할게요!"
        mainView.messageLabel.text = "상대방이 요청을 수락하면\n채팅창에서 대화를 나눌 수 있어요"
        mainView.messageLabel.textColor = .colorGray7
    }
    
    func buttonSetting() {
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        
        mainView.okButton.addTarget(self, action: #selector(method), for: .touchUpInside)
    }
    
    @objc func cancelButtonClicked() {
        self.dismiss(animated: false)
    }
    
    //MARK: 스터디 요청하기 버튼
    @objc func okButtonClikced() {
        print("넘어온 유저 UID: \(userUID)")
        requestStudy(userUID: userUID ?? "")
    }
    
    //MARK: 스터디 요청
    func requestStudy(userUID: String) {
        modelView.requestStudy(otherUID: userUID ?? "error") { statusCode in
            switch statusCode {
            case 200:
                print("스터디 요청 성공 ✅✅✅✅✅")
                self.view.makeToast("스터디 요청을 보냈습니다", position: .bottom)
                
                return
            case 201:
                print("상대방이 이미 나에게 스터디 요청 ✅✅✅✅✅")
                self.acceptStudy(userUID: userUID)
                
                return
            case 202:
                print("상대방이 새싹 찾기를 중단한 상태 ⛔️⛔️⛔️⛔️⛔️")
                self.view.makeToast("상대방이 스터디 찾기를 그만두었습니다.", position: .top)
                
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
    
    //MARK: 스터디 수락
    func acceptStudy(userUID: String) {
        modelView.acceptStudy(otherUID: userUID ?? "error") { statusCode in
            switch statusCode {
            case 200:
                print("스터디 수락 성공 ✅✅✅✅✅")
                let vc = ChattingViewController()
                
                self.navigationController?.pushViewController(vc, animated: true)
                
                return
            case 201:
                print("상대방이 이미 나에게 스터디 요청 ✅✅✅✅✅")
                self.view.makeToast("상대방이 이미 다른 새싹과 스터디를 함께 하는 중입니다.", position: .top)
                
                return
            case 202:
                print("상대방이 새싹 찾기를 중단한 상태 ⛔️⛔️⛔️⛔️⛔️")
                self.view.makeToast("상대방이 스터디 찾기를 그만두었습니다.", position: .top)
                
                return
            case 203:
                print("내가 이미 다른 사용자와 매칭된 상태 ⛔️⛔️⛔️⛔️⛔️")
                self.view.makeToast("앗! 누군가가 나의 스터디를 수락하였어요!", position: .top)
                
                //마이큐 스테이트 호출
                
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
    
    func userQueueState() {
        modelView.myQueueState { (data, statusCode) in
            switch statusCode {
            case 200:
                
                return
            case 201:
                
                return
            case 401:
                
                return
            case 406:
                
                return
            case 500:
                
                return
            case 501:
                
                return
                
            default:
                print("default ❌")
            }
        }
    }
}

