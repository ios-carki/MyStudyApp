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
        
        //input 1: phoneNum TextField
        mainView.inputPhoneNumberTextField.rx.text
            .orEmpty
            .bind(to: viewModel.phoneNumText)
            .disposed(by: disposeBag)
        
        //output2: 폰넘버 체크 결과
        viewModel.isPhoneNumValid
        //bind(to:~) -> bool값밖에 못받음
            .bind{ value in
                if value {
                    self.mainView.getCertificationNumberButton.backgroundColor = .colorGreen
                } else {
                    self.mainView.getCertificationNumberButton.backgroundColor = .colorGray3
                }
            }
            .disposed(by: disposeBag)
        //output1: button background color
        
    }
}
