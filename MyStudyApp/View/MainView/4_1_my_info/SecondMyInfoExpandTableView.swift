//
//  SecondMyInfoDetailTableView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/14.
//

import UIKit

import SnapKit

final class SecondMyInfoExpandTableView: UITableViewCell {
    static let identifier = "myInfoExpandCell"
    
    //MARK: 새싹 타이틀
    let sesacTitleView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        return view
    }()
    
    let sesacTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "새싹 타이틀"
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    //MARK: 타이틀 컬랙션뷰
    let titleCollectionView: UICollectionView = {
        func setLatout() -> UICollectionViewLayout {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            layout.minimumLineSpacing = 5
            layout.minimumInteritemSpacing = 1
            
            return layout
        }
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: setLatout())
        cv.backgroundColor = .green
        return cv
    }()
    
    //MARK: 새싹 리뷰
    let sesacReViewView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    let sesacReviewLabel: UILabel = {
        let view = UILabel()
        view.text = "새싹 리뷰"
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    let sesacReviewTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "첫 리뷰를 기다리는 중이에요!"
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        [sesacTitleLabel, titleCollectionView].forEach {
            sesacTitleView.addSubview($0)
        }
        
        [sesacReviewLabel, sesacReviewTextField].forEach {
            sesacReViewView.addSubview($0)
        }
        
        [sesacTitleView, sesacReViewView].forEach {
            contentView.addSubview($0)
        }
        self.backgroundColor = .systemCyan
        self.selectionStyle = .none
        
//        titleCollectionView.delegate = self
//        titleCollectionView.dataSource = self
    }
    
    private func setConstraints() {
        sesacTitleView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        sesacTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(sesacTitleView.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(sesacTitleView.safeAreaLayoutGuide)
            make.height.equalTo(18)
        }
        
        titleCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sesacTitleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(sesacTitleView.safeAreaLayoutGuide)
            make.bottom.equalTo(sesacTitleView.safeAreaLayoutGuide)
        }
        
        //사이즈 수정 필요
        sesacReViewView.snp.makeConstraints { make in
            make.top.equalTo(sesacTitleView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
        }
        
        sesacReviewLabel.snp.makeConstraints { make in
            make.top.equalTo(sesacReViewView.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(sesacReViewView.safeAreaLayoutGuide)
            make.height.equalTo(18)
        }
        
        sesacReviewTextField.snp.makeConstraints { make in
            make.top.equalTo(sesacReviewLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(sesacReViewView.safeAreaLayoutGuide)
            make.bottom.equalTo(sesacReViewView.safeAreaLayoutGuide)
            make.height.equalTo(24)
        }
        
    }
}

//extension SecondMyInfoExpandTableView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//
//
//}
