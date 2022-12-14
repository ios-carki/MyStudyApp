//
//  MVVMFirstLoginViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/16.
//

import UIKit

import RxSwift
import RxCocoa

final class MVVMFirstLoginViewController: UIViewController {
    
    let viewModel = FristLoginViewModel()
    let disposeBag = DisposeBag()
    let mainView = LoginView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
    }
    
    private func bindUI() {
        
        let validation = mainView.inputPhoneNumberTextField.rx.text
            .orEmpty
            .map { $0.count > 9 }
            .share()
        
        //input 1: phoneNum TextField
        mainView.inputPhoneNumberTextField.rx.text
            .orEmpty
            .bind(to: viewModel.phoneNumText)
            .disposed(by: disposeBag)
        
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
        
        
        
        //output2: 폰넘버 체크 결과
        //output1: button background color
        viewModel.isPhoneNumValid
        //bind(to:~) -> bool값밖에 못받음
            .bind{ value in
                if value {
                    
                    self.mainView.getCertificationNumberButton.backgroundColor = .colorGreen
                } else {
                    self.mainView.getCertificationNumberButton.backgroundColor = .colorGray6
                }
            }
            .disposed(by: disposeBag)
        
        
    }
}
