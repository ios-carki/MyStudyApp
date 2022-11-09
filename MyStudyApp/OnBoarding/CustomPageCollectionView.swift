//
//  CustomPageCollectionView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/07.
//

import UIKit

import SnapKit

final class CustomPageCollectionView: UICollectionViewCell {
    
    static let identifier = "PageViewCell"
    
    let pageTopLabel: UILabel = {
        let view = UILabel()
        view.text = "위치 기반으로 빠르게\n주위 친구를 확인"
        view.numberOfLines = 0
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 24)
        return view
    }()
    
    let pageImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "onboarding_img1")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCellUI()
        setCellConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellUI() {
        [pageTopLabel, pageImage].forEach {
            contentView.addSubview($0)
        }
        self.backgroundColor = .white
        
    }
    
    func setCellConstraints() {
        
        pageTopLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(85)
        }
        
        pageImage.snp.makeConstraints { make in
            make.top.equalTo(pageTopLabel.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(8)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
