//
//  MatchingStudyView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/16.
//

import UIKit

import SnapKit

final class MatchingStudyView: BaseView {
    
    let arroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let arroundLabel: UILabel = {
        let view = UILabel()
        view.text = "지금 주변에는"
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    let arroundCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let userWantView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    let userWantLabel: UILabel = {
        let view = UILabel()
        view.text = "내가 하고 싶은"
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    let userWantCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let searchSesacButton: UIButton = {
        let view = UIButton()
        view.setTitle("새싹 찾기", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.backgroundColor = .colorGreen
        view.layer.cornerRadius = 8
        return view
    }()
    
    override func configureUI() {
        [arroundLabel, arroundCollectionView].forEach {
            arroundView.addSubview($0)
        }
        
        [userWantLabel, userWantCollectionView].forEach {
            userWantView.addSubview($0)
        }
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        
        arroundView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(32)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).offset(16)
            make.height.equalTo(146)
        }
        
        arroundLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(arroundView.safeAreaLayoutGuide)
            make.height.equalTo(18)
        }
        
        arroundCollectionView.snp.makeConstraints { make in
            make.top.equalTo(arroundLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(arroundView.safeAreaLayoutGuide)
        }
        
        userWantView.snp.makeConstraints { make in
            make.top.equalTo(arroundView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(146)
        }
        
        userWantLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(userWantView.safeAreaLayoutGuide)
            make.height.equalTo(18)
        }
        
        userWantCollectionView.snp.makeConstraints { make in
            make.top.equalTo(userWantLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(userWantView.safeAreaLayoutGuide)
        }
    }
}
