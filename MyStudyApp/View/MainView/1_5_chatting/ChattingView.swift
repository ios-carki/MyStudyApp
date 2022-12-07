//
//  ChattingView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/22.
//

import UIKit

import SnapKit

final class ChattingView: BaseView {
    
    let messageTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        return view
    }()
    
    let textAreaView: UIView = {
        let view = UIView()
        view.backgroundColor = .colorGray1
        view.layer.cornerRadius = 8
        return view
    }()
    
    let userTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .colorGray1
        view.textColor = .black
        view.textAlignment = .left
        return view
    }()
    
    let sendButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "sendInact"), for: .normal)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func configureUI() {
        
        [userTextView, sendButton].forEach {
            textAreaView.addSubview($0)
        }
        
        [messageTableView, textAreaView].forEach {
            self.addSubview($0)
        }
        
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        
        
        messageTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        textAreaView.snp.makeConstraints { make in
            make.top.equalTo(messageTableView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(50)
        }
        
        userTextView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(textAreaView.safeAreaLayoutGuide).inset(14)
            make.leading.equalTo(textAreaView.safeAreaLayoutGuide).offset(12)
        }
        
        sendButton.snp.makeConstraints { make in
            make.leading.equalTo(userTextView.snp.trailing).offset(8)
            make.trailing.equalTo(textAreaView.safeAreaLayoutGuide).offset(-12)
            make.centerY.equalTo(textAreaView.safeAreaLayoutGuide)
            make.size.equalTo(24)
        }
    }
}
