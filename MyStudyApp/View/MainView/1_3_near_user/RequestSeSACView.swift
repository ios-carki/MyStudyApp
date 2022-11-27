//
//  ReceivedSeSACView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/27.
//

import UIKit

import SnapKit

final class RequestSeSACView: BaseView {
    
    let tabBarView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let boundaryView: UIView = {
        let view = UIView()

        return view
    }()
    
    let contentsView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    override func configureUI() {
        
        [tabBarView, boundaryView, contentsView].forEach {
            self.addSubview($0)
        }
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        tabBarView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        boundaryView.snp.makeConstraints { make in
            make.top.equalTo(tabBarView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        contentsView.snp.makeConstraints { make in
            make.top.equalTo(boundaryView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
