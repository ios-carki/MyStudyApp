//
//  ShopBackgroundCell.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/29.
//

import UIKit

import SnapKit

final class ShopBackgroundCell: BaseTableViewCell {
    static let identifier = "backgroundCell"
    
    let cellView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let backgroundImageView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    let backgroundImage: UIImageView = {
       let view = UIImageView()
        view.contentMode = .center
        return view
    }()
    
    let detailView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let backgroundNameLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 14)
        view.textColor = .black
        return view
    }()
    
    let priceLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.layer.cornerRadius = 8
        view.backgroundColor = .colorGreen
        return view
    }()
    
    let detailLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textColor = .black
        return view
    }()
    
    override func configure() {
        backgroundImageView.addSubview(backgroundImage)
        
        [backgroundNameLabel, priceLabel, detailLabel].forEach {
            detailView.addSubview($0)
        }
        
        [backgroundImageView, detailView].forEach {
            cellView.addSubview($0)
        }
        
        contentView.addSubview(cellView)
        contentView.backgroundColor = .white
    }
    
    override func setConstraints() {
        
        cellView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(8)
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(8)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalTo(cellView.safeAreaLayoutGuide)
            make.width.equalTo(backgroundImageView.snp.height)
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(backgroundImageView.safeAreaLayoutGuide)
        }
        
        detailView.snp.makeConstraints { make in
            make.centerY.equalTo(backgroundImageView.snp.centerY)
            make.leading.equalTo(backgroundImageView.snp.trailing).offset(12)
            make.trailing.equalTo(cellView.safeAreaLayoutGuide)
        }
        
        backgroundNameLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(detailView.safeAreaLayoutGuide)
            make.height.equalTo(22)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.trailing.equalTo(detailView.safeAreaLayoutGuide)
            make.height.equalTo(20)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundNameLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(detailView.safeAreaLayoutGuide)
            make.bottom.equalTo(detailView.safeAreaLayoutGuide)
        }
    }
}
