//
//  CancelMatchViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/15.
//

import UIKit

final class CancelMatchViewController: UIViewController {
    
    let mainView = MyInfoWithdrawView()
    let modelView = APIService()
    
    var otherUID: String?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetting()
        buttonSetting()
        
        print("매칭중인 사람 id: ", otherUID ?? "아이디 못받았어 ✅✅✅✅")
    }
    
    private func viewSetting() {
        mainView.signLabel.text = "스터디를 취소하겠습니까?"
        mainView.messageLabel.text = "스터디를 취소하시면 패널티가 부과됩니다"
        mainView.messageLabel.textColor = .black
    }
    
    private func buttonSetting() {
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        mainView.okButton.addTarget(self, action: #selector(okButtonClikced), for: .touchUpInside)
    }
    
    @objc func cancelButtonClicked() {
        self.dismiss(animated: false)
    }
    
    @objc func okButtonClikced() {
        cancelStudyAPI()
    }
    
    private func cancelStudyAPI() {
        modelView.dodgeStudyAPI(otherUID: otherUID ?? "") { statusCode in
            switch statusCode {
            case 200:
                UserDefaults.standard.set(2, forKey: "matchingStatus")
                self.changeRootVC()
                
                return
            default:
                self.view.makeToast("매칭취소 실패", position: .top)
                
                return
            }
        }
    }
    
    func changeRootVC() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        
        let vc = MainMapViewController()
        UIView.transition(with: (sceneDelegate?.window)!, duration: 0.6, options: [.transitionCrossDissolve], animations: nil, completion: nil)
        let nav = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()

    }
}

/*
 스터디 취소 후 메인 지도뷰로 넘어오면 텝바 사라지는 문제
 다른 사람이랑 매칭되면 다른 사람의 채팅 기록 까지 넘어오는 문제
 */
