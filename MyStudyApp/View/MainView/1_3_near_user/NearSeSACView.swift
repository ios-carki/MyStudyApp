//
//  NearSeSACView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/26.
//

import UIKit

import SnapKit

final class NearSeSACView: BaseView {
    
    let testLabel: UILabel = {
        let view = UILabel()
        view.text = "가까운 새싹 뷰"
        return view
    }()
    
    override func configureUI() {
        self.addSubview(testLabel)
        self.backgroundColor = .red
    }
    
    override func setConstraints() {
        testLabel.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
