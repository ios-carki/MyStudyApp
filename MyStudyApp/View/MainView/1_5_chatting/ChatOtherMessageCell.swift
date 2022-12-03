//
//  ChatOtherMessageCell.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/03.
//

import UIKit

final class ChatOtherMessageCell: UITableViewCell {
    
    static let identifier = "chatOtherMessageCell"
    
    let receiveView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let chatBubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.colorGray4.cgColor
        view.layer.borderWidth = 1
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
            receiveView.addSubview($0)
        }
        
        contentView.addSubview(receiveView)
        contentView.backgroundColor = .white
    }
    
    private func setConstraints() {
        
        receiveView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-56)
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        chatBubbleView.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(receiveView.safeAreaLayoutGuide)
        }
        
        chatTextLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(chatBubbleView.safeAreaLayoutGuide).inset(10)
            make.horizontalEdges.equalTo(chatBubbleView.safeAreaLayoutGuide).inset(16)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(chatBubbleView.snp.trailing).offset(8)
            make.trailing.bottom.equalTo(receiveView.safeAreaLayoutGuide)
            make.height.equalTo(18)
        }
        
    }
}
