//
//  SecondMyInfoView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/14.
//

import UIKit

import SnapKit

final class SecondMyInfoView: BaseView {
    
    let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.colorGray2.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let cardBackgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "sesac_bg_01")
        return view
    }()
    
    let cardCharImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "sesac_face_2")
        return view
    }()
    
    let detailTableView: UITableView = {
        let view = UITableView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.colorGray2.cgColor
        view.layer.cornerRadius = 8
        view.separatorStyle = .none
        return view
    }()
    
    let testView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.colorGray7.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    override func configureUI() {
        [cardBackgroundImage, cardCharImage].forEach {
            cardView.addSubview($0)
        }
        
        [cardView, detailTableView, testView].forEach {
            self.addSubview($0)
        }
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        
        cardBackgroundImage.snp.makeConstraints { make in
            make.edges.equalTo(cardView.safeAreaLayoutGuide)
        }
        
        cardCharImage.snp.makeConstraints { make in
            make.centerX.equalTo(cardView.safeAreaLayoutGuide)
            make.top.equalTo(cardView.safeAreaLayoutGuide).offset(20)
            make.bottom.equalTo(cardView.safeAreaLayoutGuide).offset(8)
        }
        
        cardView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(200)
        }
        
        detailTableView.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
}
