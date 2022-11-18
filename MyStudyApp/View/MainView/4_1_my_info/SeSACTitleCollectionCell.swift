//
//  SeSACTitleCollectionCell.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/19.
//

import UIKit

import SnapKit

final class SeSACTitleCollectionCell: UICollectionViewCell {
    static let identifier = "titleCell"
    
    let titleButton: UIButton = {
        let view = UIButton()
        view.setTitle("타이틀 이름", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.colorGray4.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(titleButton)
    }
    
    private func setConstraints() {
        titleButton.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
