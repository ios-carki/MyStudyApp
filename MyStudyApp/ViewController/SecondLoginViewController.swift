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

        logIn(credential: credential)
    }
    
    func logIn(credential: PhoneAuthCredential) {
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
                print("LogIn Failed...")
            }
            print("LogIn Success!!")
            print("\\(authResult!)")
        }
    }
}
