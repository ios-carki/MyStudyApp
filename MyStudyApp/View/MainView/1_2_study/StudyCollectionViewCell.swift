//
//  StudyCollectionViewCell.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/23.
//

import UIKit

import SnapKit

final class StudyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "studyCell"
    
    let studyText: UILabel = {
        let view = UILabel()
        view.textColor = .colorGreen
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 14)
        view.layer.borderColor = UIColor.colorGreen.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    let deleteButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "close_small"), for: .normal)
        view.tintColor = .colorGreen
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
        [studyText, deleteButton].forEach {
            self.addSubview($0)
        }
    }
    
    private func setConstraints() {//6
        
        studyText.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(studyText.snp.trailing).offset(6)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.size.equalTo(16)
        }
    }
}
