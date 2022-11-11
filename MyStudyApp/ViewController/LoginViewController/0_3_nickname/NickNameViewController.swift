//
//  NickNameViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/08.
//

import UIKit

import Toast

/*
 1. 닉네임은 최소1자리 ~ 10자리
 2. 키보드가 미리 올라와있는 상태
 3. 금지된 단어 사용 판단
 */
final class NickNameViewController: UIViewController {
    
    let mainView = NickNameView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldSetting()
        nextButtonSetting()
    }
    
    func textFieldSetting() {
        mainView.inputNickNameTextField.becomeFirstResponder()
    }
    
    func nextButtonSetting() {
        mainView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    @objc func nextButtonClicked() {
        guard let nickNameText = mainView.inputNickNameTextField.text else { return }
        
        var nickName: User = User()
        nickName.nick = nickNameText
        print("유저가 설정한 닉네임: ", nickName.nick)
        print("현재 유저 데이터 상태: ", nickName)
        
        if isValidNickName(nickName: nickName.nick) {
            nextView()
        } else {
            view.makeToast("닉네임은 1자 이상 10자 이내로 부탁드려요")
        }
    }
    
    func isValidNickName(nickName: String?) -> Bool {
        guard nickName != nil else { return false }
        let pattern = "[가-힣A-Za-z0-9]{1,10}"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        
        return pred.evaluate(with: nickName)
    }
    
    func nextView() {
        let vc = BirthViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

