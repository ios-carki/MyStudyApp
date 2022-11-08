//
//  LoginViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/07.
//

import UIKit

import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    
    let mainView = LoginView()
    
    let disposeBag = DisposeBag()
    
//    let numberFormatter: NumberFormatter = {
//        let format = NumberFormatter()
//        format.numberStyle = .
//        return format
//    }()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumberTextFieldSetting()
        changeUnderLineOfTextField()
        certificatieButtonSetting()
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
    }
    
    func certificatieButtonSetting() {
        
        mainView.getCertificationNumberButton.rx.tap
            .subscribe { _ in
                print("버튼클릭됨")
            }
            .disposed(by: disposeBag)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let formatter = NumberFormatter()
                  formatter.locale = Locale(identifier: "en_US")                    // Adapt to your case
                  formatter.usesGroupingSeparator = true
                  formatter.numberStyle = NumberFormatter.Style.decimal
                  formatter.maximumFractionDigits = 6
                  formatter.decimalSeparator = "."                                  // Adapt to your case
                  formatter.groupingSeparator = "-"                                 // Adapt to your case
                  
                  // The complete string if string were added at the end
                 // Here we only insert figures at the end

                  // Let us first remove extra groupingSeparator we may have introduced to find the number
                  let completeString = textField.text!.replacingOccurrences(of: formatter.groupingSeparator, with: "") + string

                  var backSpace = false
                  
                  if let char = string.cString(using: String.Encoding.utf8) {
                      let isBackSpace = strcmp(char, "\\b")
                      if (isBackSpace == -92) {
                          backSpace = true
                      }
                  }
                  if string == "" && backSpace {           // backspace inserts nothing, but we need to accept it.
                      return true
                  }
                  if string == "-" && textField.text! == "" {  // Accept leading minus
                      return true
                  }

                  guard let value = Double(completeString) else { return false } // No double ; We do not insert
                  
                  let formattedNumber = formatter.string(from: NSNumber(value: value)) ?? ""
                  textField.text = formattedNumber // We update the textField, adding typed character
                  
                  return string == formatter.decimalSeparator
    }
}
