//
//  PagerCell.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/26.
//

import UIKit

import SnapKit

final class PagerCell: BaseCollectionViewCell {
    static let identifier = "pageCell"
    
    lazy var pageView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    override func configureUI() {
        contentView.addSubview(pageView)
    }
    
    override func setConstraints() {
        pageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
