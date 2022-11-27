//
//  MenuCell.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/26.
//

import UIKit

import SnapKit

final class MenuCell: BaseCollectionViewCell {
    static let identifier = "menuCell"
    
    let menuLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.textAlignment = .center
        return view
    }()
    
    func setTitle(title: String) {
        menuLabel.text = title
    }
    
    override var isSelected: Bool {
        willSet {
            if newValue {
                menuLabel.textColor = .colorGreen
            } else {
                menuLabel.textColor = .colorGray6
            }
        }
    }
    
    override func prepareForReuse() {
        isSelected = false
        
    }
    
    override func configureUI() {
        contentView.addSubview(menuLabel)
        contentView.backgroundColor = .yellow
    }
    
    override func setConstraints() {
        menuLabel.snp.makeConstraints { make in
            make.center.equalTo(contentView)
            make.height.equalTo(22)
        }
    }
}
