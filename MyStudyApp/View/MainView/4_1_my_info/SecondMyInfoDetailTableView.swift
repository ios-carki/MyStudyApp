//
//  SecondMyInfoDetailTableView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/14.
//

import UIKit

import SnapKit

final class SecondMyInfoDetailTableView: UITableViewCell {
    static let identifier = "myInfoDetailCell"
    
    let userNicklabel: UILabel = {
        let view = UILabel()
        view.text = "테스트"
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    let expandViewButton: UIImageView = {
        let view = UIImageView()
        view.tintColor = .colorGray7
        view.image = UIImage(systemName: "chevron.down")
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
        [userNicklabel, expandViewButton].forEach {
            contentView.addSubview($0)
        }
        self.selectionStyle = .none
    }
    
    private func setConstraints() {
        
        userNicklabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
        }
        
        expandViewButton.snp.makeConstraints { make in
            make.centerY.equalTo(userNicklabel.snp.centerY)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.width.equalTo(16)
        }
    }
}
