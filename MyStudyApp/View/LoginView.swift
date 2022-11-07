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
    
    let borderLineView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.colorGray3.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let getCertificationNumberButton: UIButton = {
        let view = UIButton()
        view.setTitle("인증 문자 받기", for: .normal)
        view.setTitleColor(.colorGray3, for: .normal)
        view.isEnabled = true
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.layer.cornerRadius = 8
        view.backgroundColor = .colorGray6
        return view
    }()
    
    override func configureUI() {
        [descriptionLabelInputPhoneNumber, inputPhoneNumberTextField, borderLineView, getCertificationNumberButton].forEach {
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
        
        borderLineView.snp.makeConstraints { make in
            make.top.equalTo(inputPhoneNumberTextField.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(inputPhoneNumberTextField.snp.width)
            make.height.equalTo(1)
        }
        
        getCertificationNumberButton.snp.makeConstraints { make in
            make.top.equalTo(borderLineView).offset(72)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
}
