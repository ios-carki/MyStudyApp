//
//  ChatAlertCell.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/03.
//

import UIKit

final class ChatAlertCell: UITableViewCell {
    
    static let identifier = "chatAlertCell"
    
    let dateView: UIView = {
        let view = UIView()
        view.backgroundColor = .colorGray7
        view.layer.cornerRadius = 14 //Revise: 사이즈 조정 필요함
        view.clipsToBounds = true
        return view
    }()
    
    let dateLabel: UILabel = {
        let view = UILabel()
        view.text = "1월 1일 월요일"
        view.textAlignment = .center
        view.textColor = .white
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    let noticeView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let titleView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let bellImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bell")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let noticeMatchingLabel: UILabel = {
        let view = UILabel()
        view.text = "???님과 매칭되었습니다"
        view.textColor = .colorGray7
        view.font = .systemFont(ofSize: 14)
        view.textAlignment = .center
        return view
    }()
    
    let subtitleLabel: UILabel = {
        let view = UILabel()
        view.text = "채팅을 통해 약속을 정해보세요 :)"
        view.textColor = .colorGray6
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    let messageTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .brown
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        dateView.addSubview(dateLabel)
        
        [bellImage, noticeMatchingLabel].forEach {
            titleView.addSubview($0)
        }
        
        [titleView, subtitleLabel].forEach {
            noticeView.addSubview($0)
        }
        
        [userTextView, sendButton].forEach {
            textAreaView.addSubview($0)
        }
        
        [dateView, noticeView, messageTableView, textAreaView].forEach {
            self.addSubview($0)
        }
        self.backgroundColor = .white
    }
    
    private func setConstraints() {
        
        dateView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(28)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.center.equalTo(dateView.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(dateView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(18)
        }
        
        noticeView.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(noticeView.safeAreaLayoutGuide).offset(12)
            make.centerX.equalTo(noticeView.safeAreaLayoutGuide)
            make.height.equalTo(22)
        }
        
        bellImage.snp.makeConstraints { make in
            make.leading.equalTo(titleView.safeAreaLayoutGuide)
            make.centerY.equalTo(titleView.safeAreaLayoutGuide)
            make.size.equalTo(16)
        }
        
        noticeMatchingLabel.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(titleView.safeAreaLayoutGuide)
            make.leading.equalTo(bellImage.snp.trailing)
            make.height.equalTo(22)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(2)
            make.centerX.equalTo(noticeView.safeAreaLayoutGuide)
            make.height.equalTo(22)
        }
        
        messageTableView.snp.makeConstraints { make in
            make.top.equalTo(noticeView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(textAreaView.snp.top)
        }
        
        textAreaView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide)
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
