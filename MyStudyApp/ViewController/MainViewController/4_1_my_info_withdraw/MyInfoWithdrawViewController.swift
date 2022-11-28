//
//  MyInfoWithdrawViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/15.
//

import UIKit

final class MyInfoWithdrawViewController: UIViewController {
    
    let mainView = MyInfoWithdrawView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetting()
        buttonSetting()
    }
    
    func viewSetting() {
        mainView.signLabel.text = "정말 탈퇴하시겠습니까?"
        mainView.messageLabel.text = "탈퇴하시면 새싹 스터디를 이용할 수 없어요ㅠ"
        mainView.messageLabel.textColor = .black
    }
    
    func buttonSetting() {
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
    }
    
    @objc func cancelButtonClicked() {
        self.dismiss(animated: false)
    }
}
