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
        if UserDefaults.standard.bool(forKey: "numberVerifiedUser") {
            let okButton = UIAlertAction(title: "확인", style: .default) { [weak self] action in
                guard let self = self else { return }
                UserDefaults.standard.set(true, forKey: "numberVerifiedUser")
                self.isOldUser()
            }
            
            self.customAlert(alertTitle: "인증성공!", alertMessage: "유저 데이터가 확인되었습니다.", alertStyle: .alert, actions: okButton)
        } else {
            
            let okButton = UIAlertAction(title: "확인", style: .default) { [weak self] action in
                guard let self = self else { return }
                UserDefaults.standard.set(true, forKey: "numberVerifiedUser")
                self.ifNewUser()
            }
            
            self.customAlert(alertTitle: "인증성공!", alertMessage: "회원정보 입력화면으로 넘어갑니다.", alertStyle: .alert, actions: okButton)
        }
    }
    
    func ifNewUser() {
        let vc = NickNameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func ifOldUser() {
        //메인 지도뷰 구성하기
    }
}
