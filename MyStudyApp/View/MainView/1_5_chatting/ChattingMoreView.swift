//
//  ChattingMoreView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/15.
//

import UIKit

import SnapKit

final class ChattingMoreView: BaseView {
    
    
    let buttonStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 0
        view.backgroundColor = .white
        return view
    }()
    
    //MARK: 신고
    let reportView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let reportImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "siren")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let reportLabel: UILabel = {
        let view = UILabel()
        view.text = "새싹 신고"
        view.textColor = .black
        return view
    }()
    
    //MARK: 스터디 취소
    let cancelView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let cancelImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cancel_match")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let cancelLabel: UILabel = {
        let view = UILabel()
        view.text = "스터디 취소"
        view.textColor = .black
        return view
    }()
    
    //MARK: 리뷰
    let reviewView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let reviewImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "write")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let reviewLabel: UILabel = {
        let view = UILabel()
        view.text = "리뷰 등록"
        view.textColor = .black
        return view
    }()
    
    override func configureUI() {
        [reportImage, reportLabel].forEach {
            reportView.addSubview($0)
        }
        
        [cancelImage, cancelLabel].forEach {
            cancelView.addSubview($0)
        }
        
        [reviewImage, reviewLabel].forEach {
            reviewView.addSubview($0)
        }
        
        [reportView, cancelView, reviewView].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        self.addSubview(buttonStackView)
        self.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    override func setConstraints() {
        
        buttonStackView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(72)
        }
        
        reportImage.snp.makeConstraints { make in
            make.top.equalTo(reportView.safeAreaLayoutGuide).offset(10)
            make.centerX.equalTo(reportView.safeAreaLayoutGuide)
        }
        
        reportLabel.snp.makeConstraints { make in
            make.centerX.equalTo(reportView.safeAreaLayoutGuide)
            make.bottom.equalTo(reportView.safeAreaLayoutGuide).offset(-10)
        }
        
        cancelImage.snp.makeConstraints { make in
            make.top.equalTo(cancelView.safeAreaLayoutGuide).offset(10)
            make.centerX.equalTo(cancelView.safeAreaLayoutGuide)
        }
        
        cancelLabel.snp.makeConstraints { make in
            make.centerX.equalTo(cancelView.safeAreaLayoutGuide)
            make.bottom.equalTo(cancelView.safeAreaLayoutGuide).offset(-10)
        }
        
        reviewImage.snp.makeConstraints { make in
            make.top.equalTo(reviewView.safeAreaLayoutGuide).offset(10)
            make.centerX.equalTo(reviewView.safeAreaLayoutGuide)
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.centerX.equalTo(reviewView.safeAreaLayoutGuide)
            make.bottom.equalTo(reviewView.safeAreaLayoutGuide).offset(-10)
        }
    }
}
