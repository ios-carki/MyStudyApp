//
//  SecondMyInfoView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/14.
//

import UIKit

import SnapKit

final class SecondMyInfoView: BaseView {
    
    let testLable: UILabel = {
        let view = UILabel()
        view.text = "테스트"
        return view
    }()
    
    override func configureUI() {
        self.addSubview(testLable)
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        
        testLable.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(30)
        }
    }
}
