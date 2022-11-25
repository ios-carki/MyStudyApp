//
//  MyInfoCustomTableView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/14.
//

import UIKit

import SnapKit

final class MyInfoCustomTableView: UITableViewCell {
    static let identifier = "infoCell"
    
    let iconImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = .black
        return view
    }()
    
    let infoLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16)
        view.textColor = .black
        return view
    }()
    
    let sideIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.tintColor = .colorGray7
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
        [iconImage, infoLabel, sideIcon].forEach {
            contentView.addSubview($0)
        }
        self.selectionStyle = .none
    }
    
    private func setConstraints() {
        
        iconImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImage.snp.centerY)
            make.leading.equalTo(iconImage.snp.trailing).offset(12)
        }
        
        sideIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-22)
            make.width.equalTo(9)
        }
    }
}

