//
//  AroundStudyCollectionViewCell.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/23.
//

import UIKit

import SnapKit

final class AroundStudyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "aroundStudyCell"
    
    let cellView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.colorGray4.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    let studyText: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 14)
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
        cellView.addSubview(studyText)
        contentView.addSubview(cellView)
    }
    
    private func setConstraints() {
        
        cellView.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(32)
        }
        
        studyText.snp.makeConstraints { make in
            make.verticalEdges.equalTo(cellView.safeAreaLayoutGuide).inset(5)
            make.horizontalEdges.equalTo(cellView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(22)
        }
    }
}
