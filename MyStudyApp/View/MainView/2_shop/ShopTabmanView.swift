//
//  ShopTabmanView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/28.
//

import UIKit

import SnapKit

final class ShopTabmanView: BaseView {
    
    let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.colorGray2.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
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
    
    let saveButton: UIButton = {
        let view = UIButton()
        view.setTitle("저장하기", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .colorGreen
        view.layer.cornerRadius = 8
        return view
    }()
    
    let shopTabBarView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let boundaryView: UIView = {
        let view = UIView()
        view.backgroundColor = .colorGray2
        return view
    }()
    
    override func configureUI() {
        [cardBackgroundImage, cardCharImage, saveButton].forEach {
            cardView.addSubview($0)
        }
        
        [cardView, shopTabBarView, boundaryView].forEach {
            self.addSubview($0)
        }
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        
        cardView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(172)
        }
        
        cardBackgroundImage.snp.makeConstraints { make in
            make.edges.equalTo(cardView.safeAreaLayoutGuide)
        }
        
        cardCharImage.snp.makeConstraints { make in
            make.centerX.equalTo(cardView.safeAreaLayoutGuide)
            make.top.equalTo(cardView.safeAreaLayoutGuide).offset(20)
            make.bottom.equalTo(cardView.safeAreaLayoutGuide).offset(8)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(cardView.safeAreaLayoutGuide).offset(12)
            make.trailing.equalTo(cardView.safeAreaLayoutGuide).offset(-12)
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
        
        shopTabBarView.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        boundaryView.snp.makeConstraints { make in
            make.top.equalTo(shopTabBarView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
    }
}
