//
//  ReceiveView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/26.
//

import UIKit

import SnapKit

final class ReceiveView: BaseView {
    
    let testLabel: UILabel = {
        let view = UILabel()
        view.text = "받은 요청 뷰"
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
