//
//  MyInfoWithdrawView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/15.
//

import UIKit

import SnapKit

final class MyInfoWithdrawView: BaseView {
    
    let withDrawView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    let messageView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let signLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    let messageLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = .colorGray7
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    let buttonStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 8
        return view
    }()
    
    let cancelButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 8
        view.setTitle("취소", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.backgroundColor = .colorGray2
        return view
    }()
    
    let okButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 8
        view.setTitle("확인", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.backgroundColor = .colorGreen
        return view
    }()
    
    override func configureUI() {
        [signLabel, messageLabel].forEach {
            messageView.addSubview($0)
        }
        
        [cancelButton, okButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        [messageView, buttonStackView].forEach {
            withDrawView.addSubview($0)
        }
        
        self.addSubview(withDrawView)
        self.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    override func setConstraints() {
        withDrawView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        messageView.snp.makeConstraints { make in
            make.top.equalTo(withDrawView.safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalTo(withDrawView.safeAreaLayoutGuide).inset(16)
        }
        
        signLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(messageView.safeAreaLayoutGuide)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(signLabel.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalTo(messageView.safeAreaLayoutGuide)
            //height줘야됨 22
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(messageView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(withDrawView.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(withDrawView.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(48)
        }
        
        
        
    }
    
}
