//
//  LoginViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/07.
//

import UIKit

import FirebaseAuth
import FirebaseCore
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    
    let mainView = LoginView()
    
    let disposeBag = DisposeBag()
    
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumberTextFieldSetting()
        changeUnderLineOfTextField()
        certificatieButtonSetting()
        navigationSetting()
        
    }
    
    func navigationSetting() {
        
        navigationController?.navigationBar.backgroundColor = .black
    }
    
    //MARK: - 이런식으로도 구현 할 수 있겠지만 같은코드에 컨트롤 이벤트만 달라서 조건문 활용해도 되는게 아닌지 혹은 델리게이트 or 다른 컨트롤 이벤트가 있는지
    func changeUnderLineOfTextField() {
        
        mainView.inputPhoneNumberTextField.rx.controlEvent(.editingDidBegin)
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.mainView.borderLineView.layer.borderColor = UIColor.colorFocus.cgColor
            })
            .disposed(by: disposeBag)
        
        mainView.inputPhoneNumberTextField.rx.controlEvent(.editingDidEnd)
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.mainView.borderLineView.layer.borderColor = UIColor.colorGray3.cgColor
            })
            .disposed(by: disposeBag)
    }
    //MARK: -
    
    func phoneNumberTextFieldSetting() {
        mainView.inputPhoneNumberTextField.delegate = self
        
        mainView.inputPhoneNumberTextField.rx.text.orEmpty
            .map { $0.count >= 11 }
            .bind(to: mainView.getCertificationNumberButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        print(mainView.inputPhoneNumberTextField.text)
    }
    
    func verifyPhoneNumber(textFieldText: String) -> String {
        let replaceNumber = String((textFieldText.replacingOccurrences(of: "-", with: "")).dropFirst(1))
        
        return replaceNumber
    }
    
    func certificatieButtonSetting() {
        
        mainView.getCertificationNumberButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let textFieldPhoneNumber = self?.verifyPhoneNumber(textFieldText: self?.mainView.inputPhoneNumberTextField.text ?? "") else { return }
                let userPhoneNumber = "+82\(textFieldPhoneNumber)"
                
                if ((self?.isValidPhone(phone: self?.mainView.inputPhoneNumberTextField.text)) != false) {
                    print("맞는 번호형식: ", self?.mainView.inputPhoneNumberTextField.text)
                    
                    Auth.auth().languageCode = "kr"
                    PhoneAuthProvider.provider()
                    .verifyPhoneNumber(userPhoneNumber, uiDelegate: nil) { (verificationID, error) in //번호에서 0 빼고 +82랑 붙여쓰기
//
                          if let error = error {
                              print(userPhoneNumber)
                              print("🩴🩴🩴🩴🩴에러.로컬라이즈드~🩴🩴🩴🩴🩴🩴🩴🩴🩴", error.localizedDescription)
                              print("😡😡😡😡😡😡얜 그냥 에러😡😡😡😡😡😡😡", error)
                              return
                          } else {
                              UserDefaults.standard.set(verificationID, forKey: "verificationID")
                              print("성공!")
                          }

                      }
                    
                } else {
                    print("다른 번호 형식")
                }
                let vc = SecondLoginViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func isValidPhone(phone: String?) -> Bool {
        guard phone != nil else { return false }

        //let regex = "^01[0-1, 7][0-9]{7,8}$"
        
        let phoneRegEx = "^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$"
        //let phoneRegEx = "^01[0-1, 7][0-9]{7,8}$"
        let pred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return pred.evaluate(with: phone)
    }
    
    
    
}



extension LoginViewController: UITextFieldDelegate {
    
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return false }
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = format(with: "XXX-XXXX-XXXX", phone: newString)
            return false
        }
}

/*
 // 한 글자 입력시 호출
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         let utf8Char = string.cString(using: .utf8)
         let isBackSpace = strcmp(utf8Char, "\\b")
         if string.hasCharacters() || isBackSpace == -92{
             return true
         }
         return false
     }
 */
