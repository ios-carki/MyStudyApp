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
    
//    //MARK: 성별
//    let genderView: UIView = {
//        let view = UIView()
//
//        return view
//    }()
//
//    let userGenderLabel: UILabel = {
//        let view = UILabel()
//        view.text = "내 성별"
//        view.font = .systemFont(ofSize: 14)
//        return view
//    }()
//
//    let genderStackView: UIStackView = {
//        let view = UIStackView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.axis = .horizontal
//        view.alignment = .fill
//        view.distribution = .fillEqually
//        view.spacing = 16
//        return view
//    }()
//
//    let manView: UIView = {
//        let view = UIView()
//        view.layer.cornerRadius = 8
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.colorGray3.cgColor // 바꿔야될수도있음
//        return view
//    }()
//
//    let selectMan: UILabel = {
//        let view = UILabel()
//        view.text = "남자"
//        view.font = .systemFont(ofSize: 14)
//        return view
//    }()
//
//    let womanView: UIView = {
//        let view = UIView()
//        view.layer.cornerRadius = 8
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.colorGray3.cgColor // 바꿔야될수도있음
//        return view
//    }()
//
//    let selectWoman: UILabel = {
//        let view = UILabel()
//        view.text = "여자"
//        view.font = .systemFont(ofSize: 14)
//        return view
//    }()
//
//    //MARK: 자주하는 스터디
//    let mainStudyView: UIView = {
//        let view = UIView()
//
//        return view
//    }()
//
//    let inputStudyTextField: UITextField = {
//        let view = UITextField()
//        view.placeholder = "스터디를 입력해 주세요"
//        return view
//    }()
//
//    let textFieldUnderline: UIView = {
//        let view = UIView()
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.colorGray3.cgColor
//        return view
//    }()
//
//    //MARK: 내 번호 검색 허용
//    let searchPhoneNumView: UIView = {
//        let view = UIView()
//
//        return view
//    }()
//
//    let searchPhoneNumLabel: UILabel = {
//        let view = UILabel()
//        view.text = "내 번호 검색 허용"
//        view.font = .systemFont(ofSize: 14)
//        return view
//    }()
//
//    let searchPhoneNumSwitch: UISwitch = {
//        let view = UISwitch()
//
//        return view
//    }()
//
//    //MARK: 상대방 연령대
//    let userAgeGroupView: UIView = {
//        let view = UIView()
//
//        return view
//    }()
//
//    let userAgeGroupLabel: UILabel = {
//        let view = UILabel()
//        view.text = "상대방 연령대"
//        view.font = .systemFont(ofSize: 14)
//        return view
//    }()
//
//    let exampleAgeGrouplabel: UILabel = {
//        let view = UILabel()
//        view.text = "테스트라인"
//        view.textColor = .colorGreen
//        view.font = .systemFont(ofSize: 14)
//        return view
//    }()
//
//    let userAgeGroupSlider: UISlider = {
//        let view = UISlider()
//
//        return view
//    }()
//
//    //MARK: 회원탈퇴
//    let resignButton: UIButton = {
//        let view = UIButton()
//        view.setTitle("회원탈퇴", for: .normal)
//        view.titleLabel?.font = .systemFont(ofSize: 14)
//        return view
//    }()
    //MARK: 새싹 타이틀
    let sesacTitleView: UIView = {
        let view = UIView()
        
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
        func createLayout() -> UICollectionViewLayout {
            let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            let layout = UICollectionViewCompositionalLayout.list(using: config)
            
            return layout
        }
        
        let view = UICollectionView(frame: .init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: createLayout())
        view.translatesAutoresizingMaskIntoConstraints = true
        
        return view
    }()
    
    //MARK: 새싹 리뷰
    let sesacReViewView: UIView = {
        let view = UIView()
        
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
        
        self.selectionStyle = .none
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
            make.top.equalTo(sesacTitleView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(60)
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
        }
        
    }
}
