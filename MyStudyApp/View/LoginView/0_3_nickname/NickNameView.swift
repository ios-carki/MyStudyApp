//
//  NickNameView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/08.
//

import UIKit

import SnapKit

final class NickNameView: BaseView {
    
    let inputNickNameLabel: UILabel = {
        let view = UILabel()
        view.text = "닉네임을 입력해 주세요"
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 20)
        return view
    }()
    
    let inputNickNameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "10자 이내로 입력"
        return view
    }()
    
    let textFieldUnderLine: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.colorGray3.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let nextButton: UIButton = {
        let view = UIButton()
        view.setTitle("다음", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.layer.cornerRadius = 8
        view.backgroundColor = .colorGray3
        return view
    }()
    
    override func configureUI() {
        [inputNickNameLabel, inputNickNameTextField, textFieldUnderLine, nextButton].forEach {
            self.addSubview($0)
        }
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        
        inputNickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(96)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(32)
        }
        
        inputNickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(inputNickNameLabel.snp.bottom).offset(92)
            make.leading.equalToSuperview().offset(28)
        }
        
        textFieldUnderLine.snp.makeConstraints { make in
            make.top.equalTo(inputNickNameTextField.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldUnderLine.snp.bottom).offset(72)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
}
