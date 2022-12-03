//
//  NearSeSACView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/27.
//

import UIKit

import SnapKit

final class NearSeSACView: BaseView {
    
    let tabBarView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let boundaryView: UIView = {
        let view = UIView()

        return view
    }()
    
    let contentsView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let haveDataView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let arroundSesacTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.separatorStyle = .none
        return view
    }()
    
    let nilDataView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let sesacImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "nonimg")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "아쉽게도 주변에 새싹이 없어요ㅠ"
        view.textAlignment = .center
        view.textColor = .black
        view.font = .systemFont(ofSize: 20)
        return view
    }()
    
    let messageLabel: UILabel = {
        let view = UILabel()
        view.text = "스터디를 변경하거나 조금만 더 기다려 주세요!"
        view.textAlignment = .center
        view.textColor = .colorGray7
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    let searchSectionView: UIView = {
        let view = UIView()

        return view
    }()

    let changeStudyButton: UIButton = {
        let view = UIButton()
        view.setTitle("스터디 변경하기", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.backgroundColor = .colorGreen
        view.layer.cornerRadius = 8
        return view
    }()

    let refreshButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "bt_refresh"), for: .normal)
        return view
    }()
    
    override func configureUI() {
        haveDataView.addSubview(arroundSesacTableView)
        
        [sesacImageView, titleLabel, messageLabel, searchSectionView].forEach {
            nilDataView.addSubview($0)
        }
        
        [changeStudyButton, refreshButton].forEach {
            searchSectionView.addSubview($0)
        }
        
        [haveDataView, nilDataView].forEach {
            contentsView.addSubview($0)
        }
        
        [tabBarView, boundaryView, contentsView].forEach {
            self.addSubview($0)
        }
        
        haveDataView.isHidden = false
        nilDataView.isHidden = true
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        
        tabBarView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        boundaryView.snp.makeConstraints { make in
            make.top.equalTo(tabBarView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        contentsView.snp.makeConstraints { make in
            make.top.equalTo(boundaryView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        haveDataView.snp.makeConstraints { make in
            make.edges.equalTo(contentsView.safeAreaLayoutGuide)
        }
        
        arroundSesacTableView.snp.makeConstraints { make in
            make.edges.equalTo(haveDataView.safeAreaLayoutGuide)
        }
        
        nilDataView.snp.makeConstraints { make in
            make.edges.equalTo(contentsView.safeAreaLayoutGuide)
        }
        
        sesacImageView.snp.makeConstraints { make in
            make.top.equalTo(nilDataView.safeAreaLayoutGuide).offset(183)
            make.centerX.equalTo(nilDataView.safeAreaLayoutGuide)
            make.size.equalTo(64)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(sesacImageView.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(nilDataView.safeAreaLayoutGuide)
            make.height.equalTo(32)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(nilDataView.safeAreaLayoutGuide)
            make.height.equalTo(22)
        }
        
        //이거 제약 확인
        searchSectionView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.horizontalEdges.equalTo(nilDataView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
        }
        
        changeStudyButton.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(searchSectionView.safeAreaLayoutGuide)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(searchSectionView.safeAreaLayoutGuide)
            make.leading.equalTo(changeStudyButton.snp.trailing).offset(8)
            make.size.equalTo(48)
        }
    }
    
}
