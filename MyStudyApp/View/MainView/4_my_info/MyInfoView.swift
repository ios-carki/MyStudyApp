//
//  MyInfoView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/14.
//

import UIKit

import SnapKit

final class MyInfoView: BaseView {
    
    let infoTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        return view
    }()
    
    
    override func configureUI() {
        self.addSubview(infoTableView)
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        
        infoTableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
