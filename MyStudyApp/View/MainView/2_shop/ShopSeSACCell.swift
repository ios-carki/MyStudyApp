//
//  ShopSeSACCell.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/28.
//

import UIKit

import SnapKit

final class ShopSeSACCell: BaseCollectionViewCell {
    static let identifier = "SeSACShopCell"
    
    let cellView: UIView = {
        let view = UIView()
        return view
    }()
    
    let sesacCharView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.colorGray2.cgColor
        view.backgroundColor = .white
        return view
    }()
    
    let sesacCharImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let charNameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16)
        view.textColor = .black
        return view
    }()
    
    let priceLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .colorGreen
        view.layer.cornerRadius = 30
        view.text = "기격레이블 입니다."
        return view
    }()
    
    let charDetailLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.numberOfLines = 0
        view.textColor = .black
        return view
    }()
    
    override func configureUI() {
        [sesacCharView, sesacCharImage, charNameLabel, priceLabel, charDetailLabel].forEach {
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
        
        sesacCharView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(cellView.safeAreaLayoutGuide)
            make.centerX.equalTo(cellView.safeAreaLayoutGuide)
            make.height.equalTo(165)
        }
        
        sesacCharImage.snp.makeConstraints { make in
            make.center.equalTo(sesacCharView.safeAreaLayoutGuide)
        }
        
        charNameLabel.snp.makeConstraints { make in
            make.top.equalTo(sesacCharView.snp.bottom).offset(8)
            make.leading.equalTo(cellView.safeAreaLayoutGuide)
            make.height.equalTo(26)
        }
        
        priceLabel.snp.makeConstraints { make in
            //make.height.equalTo(18)
            make.centerY.equalTo(charNameLabel.snp.centerY)
            make.trailing.equalTo(cellView.safeAreaLayoutGuide)
        }
        
        charDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(charNameLabel.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(cellView.safeAreaLayoutGuide)
        }
        
    }
    
}
