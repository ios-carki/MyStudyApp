//
//  ShopBackgroundView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/28.
//

import UIKit

import SnapKit

final class ShopBackgroundView: BaseView {
    
    let cardView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let tabView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let boundaryView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let backgroundTable: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.separatorStyle = .none
        return view
    }()
    
    override func configureUI() {
        [cardView, tabView, boundaryView, backgroundTable].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        cardView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(172)
        }
        
        tabView.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        boundaryView.snp.makeConstraints { make in
            make.top.equalTo(tabView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        backgroundTable.snp.makeConstraints { make in
            make.top.equalTo(boundaryView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            
        }
    }
}
