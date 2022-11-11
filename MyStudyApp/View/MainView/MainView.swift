//
//  MainView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/11.
//

import UIKit

import SnapKit

final class MainView: BaseView {
    
    let label: UILabel = {
        let view = UILabel()
        view.text = "메인뷰 입니다."
        view.font = .systemFont(ofSize: 20)
        view.textColor = .black
        return view
    }()
    
    override func configureUI() {
        self.addSubview(label)
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
    }
}
