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
    
    let cellView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.colorGreen.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    let studyText: UILabel = {
        let view = UILabel()
        view.textColor = .colorGreen
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    let deleteButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "cell_close_small"), for: .normal)
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
            cellView.addSubview($0)
        }
        contentView.addSubview(cellView)
    }
    
    private func setConstraints() {//6
        
        cellView.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(32)
        }
        
        studyText.snp.makeConstraints { make in
            make.centerY.equalTo(cellView.safeAreaLayoutGuide)
            make.leading.equalTo(cellView.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(22)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(cellView.safeAreaLayoutGuide)
            make.leading.equalTo(studyText.snp.trailing).offset(6)
            make.trailing.equalTo(cellView.safeAreaLayoutGuide).offset(-16)
            make.size.equalTo(16)
        }
    }
}
