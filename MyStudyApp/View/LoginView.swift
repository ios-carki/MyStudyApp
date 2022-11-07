//
//  LoginView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/07.
//

import UIKit

import SnapKit

final class LoginView: BaseView {
    
    let descriptionLabelInputPhoneNumber: UILabel = {
        let view = UILabel()
        view.text = "새싹 서비스 이용을 위해\n휴대폰 번호를 입력해 주세요"
        view.font = .systemFont(ofSize: 20)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    let inputPhoneNumberTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "휴대폰 번호(-없이 숫자만 입력)"
        return view
    }()
    
    let getCertificationNumberButton: UIButton = {
        let view = UIButton()
        view.setTitle("인증 문자 받기", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.backgroundColor = .colorGreen
        return view
    }()
    
    override func configureUI() {
        [descriptionLabelInputPhoneNumber, inputPhoneNumberTextField, getCertificationNumberButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        descriptionLabelInputPhoneNumber.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(169)
            make.horizontalEdges.equalToSuperview().inset(74)
        }
        
        inputPhoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabelInputPhoneNumber.snp.bottom).offset(76)
            make.horizontalEdges.equalToSuperview().inset(28)
        }
    }
}
