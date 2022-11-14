//
//  MainView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/11.
//

import UIKit

import SnapKit

final class MainView: BaseView {
    
    let mapView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        return view
    }()
    
    let label: UILabel = {
        let view = UILabel()
        view.text = "메인뷰 입니다."
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 20)
        view.textColor = .black
        return view
    }()
    
    
    override func configureUI() {
        mapView.addSubview(label)
        self.addSubview(mapView)
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        label.snp.makeConstraints { make in
            make.center.equalTo(mapView.safeAreaLayoutGuide)
            make.size.equalTo(200)
        }
    }
}
