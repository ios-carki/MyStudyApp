//
//  ChatMessageCell.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/03.
//
import UIKit

import SnapKit

final class ChatMyMessageCell: UITableViewCell {
    
    static let identifier = "chatMyMessageCell"
    
    let sendView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let chatBubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .colorWhiteGreen
        return view
    }()
    
    let chatTextLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .black
        view.font = .systemFont(ofSize: 14)
        view.numberOfLines = 0
        return view
    }()
    
    let timeLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .colorGray6
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        chatBubbleView.addSubview(chatTextLabel)
        
        [chatBubbleView, timeLabel].forEach {
            sendView.addSubview($0)
        }
        
        contentView.addSubview(sendView)
        contentView.backgroundColor = .white
    }
    
    private func setConstraints() {
        
        sendView.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        chatBubbleView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(sendView.safeAreaLayoutGuide)
        }
        
        chatTextLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(chatBubbleView.safeAreaLayoutGuide).inset(10)
            make.horizontalEdges.equalTo(chatBubbleView.safeAreaLayoutGuide).inset(16)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(chatBubbleView.snp.leading).offset(-8)
            make.leading.bottom.equalTo(sendView.safeAreaLayoutGuide)
            make.height.equalTo(18)
        }
    }
    
    
}
