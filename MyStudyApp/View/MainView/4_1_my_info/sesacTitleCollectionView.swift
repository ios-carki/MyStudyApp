//
//  sesacTitleCollectionView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/15.
//

import UIKit

import SnapKit

final class sesacTitleCollectionView: UICollectionViewCell {
    static let identifier = "titleColCell"
    
    let userTitleButton: UIButton = {
        let view = UIButton()
        view.setTitle("좋은 매너", for: .normal)
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.colorGray3.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(userTitleButton)
    }
       
    private func setLayout() {
        userTitleButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
