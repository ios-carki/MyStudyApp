//
//  EmailView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/08.
//

import UIKit

import SnapKit

final class EmailView: BaseView {
    
    let inputEmailLabel: UILabel = {
        let view = UILabel()
        view.text = "이메일을 입력해 주세요"
        view.font = .systemFont(ofSize: 20)
        view.textAlignment = .center
        return view
    }()
    
    let detailLabel: UILabel = {
        let view = UILabel()
        view.text = "휴대폰 번호 변경 시 인증을 위해 사용해요"
        view.textColor = .colorGray7
        view.font = .systemFont(ofSize: 16)
        view.textAlignment = .center
        return view
    }()
    
    let emailTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "SeSAC@email.com"
        return view
    }()
    
    let boundaryLine: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.colorGray3.cgColor
        return view
    }()
    
    let nextButton: UIButton = {
        let view = UIButton()
        view.setTitle("다음", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.layer.cornerRadius = 8
        view.backgroundColor = .colorGray6
        return view
    }()
    
    override func configureUI() {
        [inputEmailLabel, detailLabel, emailTextField, boundaryLine, nextButton].forEach {
            self.addSubview($0)
        }
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        
        inputEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(80)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(32)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(inputEmailLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(26)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(76)
            make.horizontalEdges.equalToSuperview().inset(28)
        }
        
        boundaryLine.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(boundaryLine.snp.bottom).offset(72)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
    
    
}
