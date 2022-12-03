//
//  ChatAlertCell.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/03.
//

import UIKit

final class ChatAlertCell: UITableViewCell {
    
    static let identifier = "chatAlertCell"
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        [bellImage, noticeMatchingLabel].forEach {
            titleView.addSubview($0)
        }
        
        [titleView, subtitleLabel].forEach {
            noticeView.addSubview($0)
        }
        
        contentView.addSubview(noticeView)
        
        self.backgroundColor = .white
    }
    
    private func setConstraints() {
        noticeView.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(78)
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
    }
}
