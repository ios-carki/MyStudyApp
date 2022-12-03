//
//  ChatDateCell.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/03.
//

import UIKit

import SnapKit

final class ChatDateCell: UITableViewCell {
    static let identifier = "chatDateCell"
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        dateView.addSubview(dateLabel)
        contentView.addSubview(dateView)
    }
    
    private func setConstraints() {
        
        dateView.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(130)
            make.height.equalTo(28)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.center.equalTo(dateView.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(dateView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(18)
        }
        
    }
    
}
