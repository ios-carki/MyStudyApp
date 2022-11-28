//
//  NearUserPopupViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/29.
//

//배경색 * dismiss안됨
import UIKit

final class NearUserPopupViewController: UIViewController {
    private let mainView = MyInfoWithdrawView()
    
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
    
    //MARK: 스터디 요청하기
    @objc func okButtonClikced() {
        
    }
}
