//
//  SecondLoginView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/08.
//

import UIKit

import SnapKit

final class SecondLoginView: BaseView {
    
    let inputCertificationNumberLabel: UILabel = {
        let view = UILabel()
        view.text = "인증번호가 문자로 전송되었어요"
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 20)
        return view
    }()
    
    let inputCertificationNumberTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "인증번호 입력"
        view.keyboardType = .numberPad
        return view
    }()
    
    let countDownLabel: UILabel = {
        let view = UILabel()
        view.text = "05:00"
        view.textAlignment = .right
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    let textFieldUnderLine: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.colorGray3.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let reSendButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .green
        view.layer.cornerRadius = 8
        view.setTitle("재전송", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.titleLabel?.textAlignment = .center
        return view
    }()
    
    let certificationButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .black
        view.setTitle("인증하고 시작하기", for: .normal)
        view.layer.cornerRadius = 8
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.titleLabel?.textAlignment = .center
        return view
    }()
    
    override func configureUI() {
        [inputCertificationNumberLabel, inputCertificationNumberTextField, countDownLabel, textFieldUnderLine, reSendButton, certificationButton].forEach {
            self.addSubview($0)
        }
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        
        inputCertificationNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(168)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(56)
        }
        
        inputCertificationNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(inputCertificationNumberLabel.snp.bottom).offset(110)
            make.leading.equalToSuperview().offset(28)
        }
        
        countDownLabel.snp.makeConstraints { make in
            make.centerY.equalTo(inputCertificationNumberTextField.snp.centerY)
            make.trailing.equalTo(reSendButton.snp.leading).offset(-20)
            make.width.equalTo(40)
            make.height.equalTo(22)
        }
        
        reSendButton.snp.makeConstraints { make in
            make.centerY.equalTo(inputCertificationNumberTextField.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(72)
            make.height.equalTo(40)
        }
        
        textFieldUnderLine.snp.makeConstraints { make in
            make.top.equalTo(inputCertificationNumberTextField.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(reSendButton.snp.leading).offset(-8)
            make.height.equalTo(1)
        }
        
        certificationButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldUnderLine.snp.bottom).offset(72)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
}
