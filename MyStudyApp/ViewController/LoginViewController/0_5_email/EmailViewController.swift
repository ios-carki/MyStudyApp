//
//  EmailViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/08.
//

import UIKit

import Toast

final class EmailViewController: UIViewController {
    
    let mainView = EmailView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextFieldSetting()
        nextButtonSetting()
    }
    
    func emailTextFieldSetting() {
        mainView.emailTextField.becomeFirstResponder()
        
        mainView.emailTextField.delegate = self
    }
    
    func nextButtonSetting() {
        mainView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    @objc func nextButtonClicked() {
        guard let emailText = mainView.emailTextField.text else { return }
        
        
        //UPDATE: 유저데이터 빠른 확인을위해 유저디폴트 사용 -> 나중에 삭제 후 구조체 직접 대입으로 바꾸기
//        UserDefaults.standard.set(emailText, forKey: "email")
//        print("저장된 이메일 데이터: ", UserDefaults.standard.string(forKey: "email"))
        
        let user = User.shared
        user.email = emailText
        print("유저 이메일", user.email)
        
        
        if isValidEmail(email: emailText) {
            nextView()
        } else {
            view.makeToast("이메일 형식이 올바르지 않습니다.", position: .top)
        }
    }
    
    /*
     @앞에는 대문자, 숫자, 소문자, 특수문자(._%+-)가 포함 가능
     \\. 콤마를 표현하기 위해서 \\사용
     @뒤로는 대문자, 소문자, 숫자 그리고 . 기준으로 맨 마지막 문자가 2~64길이
     */
    func isValidEmail(email: String?) -> Bool {
        guard email != nil else { return false }
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        
        return pred.evaluate(with: email)
    }
    
    func nextView() {
        let vc = GenderViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension EmailViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if isValidEmail(email: textField.text) {
            mainView.nextButton.backgroundColor = .colorGreen
        } else {
            mainView.nextButton.backgroundColor = .colorGray6
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if isValidEmail(email: textField.text) {
            mainView.nextButton.backgroundColor = .colorGreen
        } else {
            mainView.nextButton.backgroundColor = .colorGray6
            view.makeToast("이메일 형식이 올바르지 않습니다.", position: .top)
        }
        
        return true
    }
    
    //올바른 이메일 = 버튼 배경, 토스트 x
    func textFieldDidEndEditing(_ textField: UITextField) {
        if isValidEmail(email: textField.text) {
            mainView.nextButton.backgroundColor = .colorGreen
        } else {
            mainView.nextButton.backgroundColor = .colorGray6
            view.makeToast("이메일 형식이 올바르지 않습니다.", position: .top)
        }
    }
}
