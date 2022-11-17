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
        
        UserDefaults.standard.set(nickNameText, forKey: "nick")
        
        //UPDATE: 유저데이터 빠른 확인을위해 유저디폴트 사용 -> 나중에 삭제 후 구조체 직접 대입으로 바꾸기
//        UserDefaults.standard.set(nickNameText, forKey: "nick")
//        print("저장된 닉네임 데이터: ", UserDefaults.standard.string(forKey: "nick"))
        
        //닉네임 저장
        let user = User.shared
        user.nick = nickNameText
    
        if isValidNickName(nickName: nickNameText) {
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


//닉네임필드 다 쓰면 다음버튼 배경색 바꾸기
