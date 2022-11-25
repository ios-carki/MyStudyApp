//
//  MatchingStudyView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/16.
//

import UIKit

import SnapKit

final class MatchingStudyView: BaseView {
    
    let studyCollectionView: UICollectionView = {
        
        var layout = UICollectionViewFlowLayout()
        let content: CGFloat = UIScreen.main.bounds.width / 3.0
        
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.estimatedItemSize = CGSize(width: content - 30, height: 32)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()

    let searchBar: UISearchBar = {
        let bounds = UIScreen.main.bounds.width
        let view = UISearchBar(frame: CGRect(x: 0, y: 0, width: bounds - 28, height: 0))
        
        return view
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
//        [arroundLabel, arroundCollectionView].forEach {
//            arroundView.addSubview($0)
//        }
//
//        [userWantLabel, userWantCollectionView].forEach {
//            userWantView.addSubview($0)
//        }
        
        [studyCollectionView, searchSesacButton].forEach {
            self.addSubview($0)
        }
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        
        studyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(32)
            make.horizontalEdges.equalToSuperview()
        }
        
        searchSesacButton.snp.makeConstraints { make in
            make.top.equalTo(studyCollectionView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(16)
            make.height.equalTo(48)
        }
        
//        arroundView.snp.makeConstraints { make in
//            make.top.equalTo(safeAreaLayoutGuide).offset(32)
//            make.horizontalEdges.equalTo(safeAreaLayoutGuide).offset(16)
//            make.height.equalTo(146)
//        }
//
//        arroundLabel.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(arroundView.safeAreaLayoutGuide)
//            make.height.equalTo(18)
//        }
//
//        arroundCollectionView.snp.makeConstraints { make in
//            make.top.equalTo(arroundLabel.snp.bottom)
//            make.horizontalEdges.bottom.equalTo(arroundView.safeAreaLayoutGuide)
//        }
//
//        userWantView.snp.makeConstraints { make in
//            make.top.equalTo(arroundView.snp.bottom)
//            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
//            make.height.equalTo(146)
//        }
//
//        userWantLabel.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(userWantView.safeAreaLayoutGuide)
//            make.height.equalTo(18)
//        }
//
//        userWantCollectionView.snp.makeConstraints { make in
//            make.top.equalTo(userWantLabel.snp.bottom)
//            make.horizontalEdges.bottom.equalTo(userWantView.safeAreaLayoutGuide)
//        }
    }
}
