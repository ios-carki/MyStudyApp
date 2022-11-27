//
//  NearUserEmptyView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/20.
//

import UIKit

import SnapKit

final class TabManView: BaseView {
    
    let tabBarView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let boundaryView: UIView = {
        let view = UIView()
        view.backgroundColor = .colorGray2

        return view
    }()
    
    override func configureUI() {
        
        [tabBarView, boundaryView].forEach {
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
        
    }
    
    
}
