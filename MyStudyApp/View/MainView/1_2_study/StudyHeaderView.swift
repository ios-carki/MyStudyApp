//
//  StudyHeaderView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/24.
//

import UIKit

import SnapKit

final class StudyHeaderView: UICollectionReusableView {
    static let identifier = "headerCell"
    
    let headerLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .systemFont(ofSize: 12)
        view.textAlignment = .left
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
        
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.addSubview(headerLabel)
    }
    
    func setConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
    }
    
    
}
