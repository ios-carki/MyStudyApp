//
//  SplashView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/17.
//

import UIKit

import SnapKit

final class SplashView: BaseView {
    
    let logoImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "splash_logo")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let sesacImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "txt")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func configureUI() {
        [logoImage, sesacImage].forEach {
            self.addSubview($0)
        }
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(220)
            make.horizontalEdges.equalToSuperview().inset(80)
        }
        
        sesacImage.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(36)
            make.horizontalEdges.equalToSuperview().inset(42)
            make.height.equalTo(100)
        }
    }
}
