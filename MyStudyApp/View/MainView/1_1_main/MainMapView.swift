//
//  MainMapView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/16.
//

import UIKit
import MapKit

import SnapKit
import JJFloatingActionButton

final class MainMapView: BaseView {
    
    let mainMapView: MKMapView = {
        let view = MKMapView()
        view.mapType = MKMapType.standard
        return view
    }()
    
    let centerIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "map_marker")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let floationButton: JJFloatingActionButton = {
        let view = JJFloatingActionButton()
        view.buttonImage = UIImage(named: "search")
        view.buttonColor = .black
        return view
    }()
    
    let genderStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 0
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    let allGenderButton: UIButton = {
        let view = UIButton()
        view.setTitle("전체", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.backgroundColor = .colorGreen
        return view
    }()
    
    let manGenderButton: UIButton = {
        let view = UIButton()
        view.setTitle("남자", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        return view
    }()
    
    let womanGenderButton: UIButton = {
        let view = UIButton()
        view.setTitle("여자", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        return view
    }()
    
    let nowLocationButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "place"), for: .normal)
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        return view
    }()
    
    override func configureUI() {
        [allGenderButton, manGenderButton, womanGenderButton].forEach {
            genderStackView.addArrangedSubview($0)
        }
        [mainMapView, centerIcon, floationButton, genderStackView, nowLocationButton].forEach {
            self.addSubview($0)
        }
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        mainMapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        centerIcon.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(48)
        }
        
        floationButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.size.equalTo(64)
        }
        
        genderStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(52)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(48)
            make.height.equalTo(144)
        }
        
        nowLocationButton.snp.makeConstraints { make in
            make.top.equalTo(genderStackView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(48)
        }
    }
}

