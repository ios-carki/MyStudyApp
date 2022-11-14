//
//  SecondLoginViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/08.
//

import UIKit

import FirebaseAuth
import FirebaseCore

final class SecondLoginViewController: UIViewController {
    
    let mainView = SecondLoginView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButtonSetting()
        verifyNumberTextFieldSetting()
    }
    
    func verifyNumberTextFieldSetting() {
        mainView.inputCertificationNumberTextField.delegate = self
    }
    
    func startButtonSetting() {
        mainView.certificationButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        guard let verificationID = UserDefaults.standard.string(forKey: "verificationID"), let verificationCode = mainView.inputCertificationNumberTextField.text else {
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )

        print("베리피케이션 아이디: ", verificationID)
        logIn(credential: credential)
    }
    
    func logIn(credential: PhoneAuthCredential) {
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
                print("LogIn Failed...")
                
                self.customAlert(alertTitle: "인증실패", alertMessage: "인증번호가 일치하지 않습니다.", alertStyle: .alert)
            }
            print("LogIn Success!!")
            print("\(authResult!)")
            print("=======인증 성공! 회원정보 입력으로 전환========")
            
            //신규 유저 기존 유저 분기
            self.isOldUser()
            
        }
    }
    
    //MARK: -
    //ViewModel로 빼기
    func isOldUser() {
        //번호인증 한번이라도 했던 유저 -> numberVerifiedUser: TRUE
        if UserDefaults.standard.bool(forKey: "numberVerifiedUser") { // 번호인증 한번이라도 한 유저
            let okButton = UIAlertAction(title: "확인", style: .default) { [weak self] action in
                guard let self = self else { return }
                self.ifOldUser()
            }
            
            self.customAlert(alertTitle: "인증성공!", alertMessage: "유저 데이터가 확인되었습니다.", alertStyle: .alert, actions: okButton)
        } else { // 번호인증 처음한 유저
            
            let okButton = UIAlertAction(title: "확인", style: .default) { [weak self] action in
                guard let self = self else { return }
                UserDefaults.standard.set(true, forKey: "numberVerifiedUser") // 이 로직 통과한 순간부터 번호인증 한 유저 = 데이터가 있는 유저
                self.ifNewUser()
            }
            
            self.customAlert(alertTitle: "인증성공!", alertMessage: "회원정보 입력화면으로 넘어갑니다.", alertStyle: .alert, actions: okButton)
        }
    }
    
    //회원정보 입력뷰
    func ifNewUser() {
        let vc = NickNameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //메인 지도뷰
    func ifOldUser() {
        let vc = MainViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //6자리 인증번호인지 검사
    func isValidVeriNumber(verinum: String?) -> Bool {
        guard verinum != nil else { return false }
        let pattern = "([0-9]{6})"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        
        return pred.evaluate(with: verinum)
    }
}

extension SecondLoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if isValidVeriNumber(verinum: textField.text) {
            mainView.certificationButton.backgroundColor = .colorGreen
        } else {
            mainView.certificationButton.backgroundColor = .colorGray6
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if isValidVeriNumber(verinum: textField.text) {
            mainView.certificationButton.backgroundColor = .colorGreen
        } else {
            mainView.certificationButton.backgroundColor = .colorGray6
            view.makeToast("인증번호 형식이 올바르지 않습니다.", position: .top)
        }
        
        return true
    }
    
    //올바른 이메일 = 버튼 배경, 토스트 x
    func textFieldDidEndEditing(_ textField: UITextField) {
        if isValidVeriNumber(verinum: textField.text) {
            mainView.certificationButton.backgroundColor = .colorGreen
        } else {
            mainView.certificationButton.backgroundColor = .colorGray6
            view.makeToast("인증번호 형식이 올바르지 않습니다.", position: .top)
        }
    }
}
