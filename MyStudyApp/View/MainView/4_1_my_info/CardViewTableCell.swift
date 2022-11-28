//
//  CardViewTableCell.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/15.
//

import UIKit

import SnapKit

final class CardViewTableCell: UITableViewCell {
    static let identifier = "cardCell"
    
    let titleData: [String] = ["좋은 매너", "정확한 시간 약속", "빠른 응답", "친절한 성격", "능숙한 실력", "유익한 시간"]
    var isClicked: [Bool] = [false, false, false, false, false, false]
    
    let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.colorGray2.cgColor
        view.layer.borderWidth = 1
        return view
    }()

    let cardBackgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "sesac_bg_01")
        return view
    }()

    let cardCharImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "sesac_face_2")
        return view
    }()
    
    let requestButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .colorError
        view.layer.cornerRadius = 8
        return view
    }()
    
    let requestButton: UILabel = {
        let view = UILabel()
        view.text = "요청하기"
        view.textColor = .white
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    let detailView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.colorGray2.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    let nickNameView: UIView = {
        let view = UIView()
        return view
    }()
    
    let nickNameLabel: UILabel = {
        let view = UILabel()
        view.text = "닉네임 설정을 해주세요."
        view.textColor = .black
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    let expandImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "down_arrow")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let titleView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "새싹 타이틀"
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    let sesacTitleCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let reviewView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let sesacReviewLabel: UILabel = {
        let view = UILabel()
        view.text = "새싹 리뷰"
        view.textAlignment = .left
        view.textColor = .black
        view.font = .systemFont(ofSize: 12)
        view.backgroundColor = .white
        return view
    }()
    
    let sesacReviewTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .white
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
        requestButtonView.addSubview(requestButton)
        
        [cardBackgroundImage, cardCharImage, requestButtonView].forEach {
            cardView.addSubview($0)
        }
        
        [nickNameLabel, expandImage].forEach {
            nickNameView.addSubview($0)
        }
        
        [titleLabel, sesacTitleCollectionView].forEach {
            titleView.addSubview($0)
        }
        
        [sesacReviewLabel, sesacReviewTextView].forEach {
            reviewView.addSubview($0)
        }
        
        [nickNameView, titleView, reviewView].forEach {
            detailView.addSubview($0)
        }
        [cardView, detailView].forEach {
            contentView.addSubview($0)
        }
        contentView.backgroundColor = .white
        
        titleView.isHidden = true
        reviewView.isHidden = true
        
        sesacTitleCollectionView.register(SeSACTitleCollectionCell.self, forCellWithReuseIdentifier: SeSACTitleCollectionCell.identifier)
        
        sesacTitleCollectionView.delegate = self
        sesacTitleCollectionView.dataSource = self
    }
    
    private func setConstraints() {
        cardBackgroundImage.snp.makeConstraints { make in
            make.edges.equalTo(cardView.safeAreaLayoutGuide)
        }

        cardCharImage.snp.makeConstraints { make in
            make.centerX.equalTo(cardView.safeAreaLayoutGuide)
            make.top.equalTo(cardView.safeAreaLayoutGuide).offset(20)
            make.bottom.equalTo(cardView.safeAreaLayoutGuide).offset(8)
        }
        
        requestButtonView.snp.makeConstraints { make in
            make.top.equalTo(cardView.safeAreaLayoutGuide).offset(12)
            make.trailing.equalTo(cardView.safeAreaLayoutGuide).offset(-12)
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
        
        requestButton.snp.makeConstraints { make in
            make.center.equalTo(requestButtonView.safeAreaLayoutGuide)
            make.height.equalTo(22)
        }

        cardView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(194)
        }
        
        detailView.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }

        nickNameView.snp.makeConstraints { make in
            make.top.equalTo(detailView.safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalTo(detailView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(26)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(nickNameView.safeAreaLayoutGuide)
            make.height.equalTo(26)
        }
        
        expandImage.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(nickNameView.safeAreaLayoutGuide).offset(0)
            make.width.equalTo(16)
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(nickNameView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(detailView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(146)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(titleView.safeAreaLayoutGuide)
            make.height.equalTo(18)
        }
        
        sesacTitleCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.bottom.equalTo(titleView.safeAreaLayoutGuide)
        }
        
        reviewView.snp.makeConstraints { make in
            make.top.equalTo(sesacTitleCollectionView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(detailView.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(detailView.safeAreaLayoutGuide).offset(-16)
        }
        
        sesacReviewLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(reviewView.safeAreaLayoutGuide)
            make.height.equalTo(18)
        }
        
        sesacReviewTextView.snp.makeConstraints { make in
            make.top.equalTo(sesacReviewLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalTo(reviewView.safeAreaLayoutGuide)
            //make.height.equalTo(24)
        }
    }
    
    
}

extension CardViewTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //셀버튼 너무 무식하게 구현했음 *** 다시 만들어보기
    func buttonSetting(buttonName: UIButton) {
        print("버튼 세팅")
        
        if isClicked[buttonName.tag] {
            buttonName.backgroundColor = .white
            buttonName.layer.borderWidth = 1
            buttonName.setTitleColor(.black, for: .normal)
            isClicked[buttonName.tag] = false
        } else {
            buttonName.backgroundColor = .colorGreen
            buttonName.layer.borderWidth = 0
            buttonName.setTitleColor(.white, for: .normal)
            isClicked[buttonName.tag] = true
        }
    }
    
    @objc func titleClicked(cellButton: UIButton) {
//        if buttonName.tag == 0 {
//            buttonName.backgroundColor = .colorGreen
//            buttonName.setTitleColor(.white, for: .normal)
//            buttonName.layer.borderWidth = 0
//        }
        print(cellButton.tag)
        switch cellButton.tag {
        case 0:
            buttonSetting(buttonName: cellButton)
            return
        case 1:
            buttonSetting(buttonName: cellButton)
            return
        case 2:
            buttonSetting(buttonName: cellButton)
            return
        case 3:
            buttonSetting(buttonName: cellButton)
            return
        case 4:
            buttonSetting(buttonName: cellButton)
            return
        case 5:
            buttonSetting(buttonName: cellButton)
            return
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let titleCell = collectionView.dequeueReusableCell(withReuseIdentifier: SeSACTitleCollectionCell.identifier, for: indexPath) as? SeSACTitleCollectionCell else {
            return UICollectionViewCell()
        }
        
        titleCell.titleButton.setTitle(titleData[indexPath.row], for: .normal)
        titleCell.titleButton.tag = indexPath.row
        
        titleCell.titleButton.addTarget(self, action: #selector(titleClicked), for: .touchUpInside)
        
        return titleCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSpacing: CGFloat = 8
        let itemWidth: CGFloat = collectionView.bounds.width / 2 - itemSpacing + 2//(collectionView.bounds.width - (itemSpacing * 2)) / 2
        
        return CGSize(width: itemWidth, height: 32)
    }
    
}
