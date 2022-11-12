//
//  GenderView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/09.
//

import UIKit

import SnapKit

final class GenderView: BaseView {
    
    let backGroundView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let selectGenderLabel: UILabel = {
        let view = UILabel()
        view.text = "성별을 선택해 주세요"
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 20)
        return view
    }()
    
    let detailTextLabel: UILabel = {
        let view = UILabel()
        view.text = "새싹 찾기 기능을 이용하기 위해서 필요해요!"
        view.textColor = .colorGray7
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    let genderStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 16
        return view
    }()
    
    let manView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.colorGray3.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    let manImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "man")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let manLabel: UILabel = {
        let view = UILabel()
        view.text = "남자"
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    let womanView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.colorGray3.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    let womanImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "woman")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let womanLabel: UILabel = {
        let view = UILabel()
        view.text = "여자"
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    let nextButton: UIButton = {
        let view = UIButton()
        view.setTitle("다음", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.layer.cornerRadius = 8
        view.backgroundColor = .colorGray6
        return view
    }()
    
    override func configureUI() {
        
        [manView, womanView].forEach {
            genderStackView.addArrangedSubview($0)
        }
        
        [manImage, manLabel].forEach {
            manView.addSubview($0)
        }
        
        [womanImage, womanLabel].forEach {
            womanView.addSubview($0)
        }
        
        [backGroundView, selectGenderLabel, detailTextLabel, genderStackView, nextButton].forEach {
            self.addSubview($0)
        }
        
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        
        backGroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        selectGenderLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(80)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(32)
        }
        
        detailTextLabel.snp.makeConstraints { make in
            make.top.equalTo(selectGenderLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(26)
        }
        
        genderStackView.snp.makeConstraints { make in
            make.top.equalTo(detailTextLabel.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(120)
        }
        
        manImage.snp.makeConstraints { make in
            make.top.equalTo(manView.safeAreaLayoutGuide).offset(14)
            make.horizontalEdges.equalTo(manView.safeAreaLayoutGuide).inset(51)
            make.centerX.equalTo(manView.safeAreaLayoutGuide)
        }
        
        manLabel.snp.makeConstraints { make in
            make.top.equalTo(manImage.snp.bottom)
            make.horizontalEdges.equalTo(manView.safeAreaLayoutGuide)
            make.bottom.equalTo(manView.safeAreaLayoutGuide).offset(-14)
        }
        
        womanImage.snp.makeConstraints { make in
            make.top.equalTo(womanView.safeAreaLayoutGuide).offset(14)
            make.horizontalEdges.equalTo(womanView.safeAreaLayoutGuide).inset(51)
            make.centerX.equalTo(womanView.safeAreaLayoutGuide)
        }
        
        womanLabel.snp.makeConstraints { make in
            make.top.equalTo(womanImage.snp.bottom)
            make.horizontalEdges.equalTo(womanView.safeAreaLayoutGuide)
            make.bottom.equalTo(womanView.safeAreaLayoutGuide).offset(-14)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(genderStackView.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
}
