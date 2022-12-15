//
//  WriteReviewView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/15.
//

import UIKit

import SnapKit

final class WriteReviewView: BaseView {
    
    let reviewView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    let topView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "리뷰 등록"
        view.textColor = .black
        view.textAlignment = .center
        return view
    }()
    
    let dismissImageButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "close_big"), for: .normal)
        return view
    }()
    
    let questionLabel: UILabel = {
        let view = UILabel()
        view.text = "dkdkdkdkdkdk tetete"
        view.textColor = .colorGreen
        view.textAlignment = .center
        return view
    }()
    
    let allStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 8
        return view
    }()
    
    let leftStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 8
        return view
    }()
    
    let rightStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 8
        return view
    }()
    
    let mannerButton: UIButton = {
        let view = UIButton()
        view.setTitle("좋은 매너", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.colorGray4.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    let responseButton: UIButton = {
        let view = UIButton()
        view.setTitle("빠른 응답", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.colorGray4.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    let abilityButton: UIButton = {
        let view = UIButton()
        view.setTitle("능숙한 실력", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.colorGray4.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    let timeButton: UIButton = {
        let view = UIButton()
        view.setTitle("정확한 시간 약속", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.colorGray4.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    let kindButton: UIButton = {
        let view = UIButton()
        view.setTitle("친절한 성격", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.colorGray4.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    let niceTimeButton: UIButton = {
        let view = UIButton()
        view.setTitle("유익한 시간", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.colorGray4.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    let reviewTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .colorGray1
        view.layer.cornerRadius = 8
        return view
    }()
    
    let registerReviewButton: UIButton = {
        let view = UIButton()
        view.setTitle("리뷰 등록하기", for: .normal)
        view.setTitleColor(.colorGray3, for: .normal)
        view.layer.cornerRadius = 8
        view.backgroundColor = .colorGray6
        return view
    }()
    
    
    override func configureUI() {
        [titleLabel, dismissImageButton, questionLabel].forEach {
            topView.addSubview($0)
        }
        
        [mannerButton, responseButton, abilityButton].forEach {
            leftStackView.addArrangedSubview($0)
        }
        
        [timeButton, kindButton, niceTimeButton].forEach {
            rightStackView.addArrangedSubview($0)
        }
        
        [leftStackView, rightStackView].forEach {
            allStackView.addArrangedSubview($0)
        }
        
        [topView, allStackView, reviewTextView, registerReviewButton].forEach {
            reviewView.addSubview($0)
        }
        
        self.addSubview(reviewView)
        self.backgroundColor = .black.withAlphaComponent(0.5)
        
    }
    
    override func setConstraints() {
        
        reviewView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        topView.snp.makeConstraints { make in
            make.top.equalTo(reviewView.safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalTo(reviewView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(62)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(topView.safeAreaLayoutGuide)
            make.height.equalTo(22)
        }
        
        dismissImageButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(topView.safeAreaLayoutGuide)
            make.leading.equalTo(titleLabel.snp.trailing)
            make.size.equalTo(24)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(topView.safeAreaLayoutGuide)
            make.bottom.equalTo(topView.safeAreaLayoutGuide)
            make.height.equalTo(22)
        }
        
        allStackView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(reviewView.safeAreaLayoutGuide).inset(16)
        }
        
        reviewTextView.snp.makeConstraints { make in
            make.top.equalTo(allStackView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(reviewView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(124)
        }
        
        registerReviewButton.snp.makeConstraints { make in
            make.top.equalTo(reviewTextView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(reviewView.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(reviewView.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(48)
        }
        
        
    }
}
