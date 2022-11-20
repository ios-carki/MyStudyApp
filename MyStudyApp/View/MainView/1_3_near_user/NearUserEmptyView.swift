//
//  NearUserEmptyView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/20.
//

import UIKit

import SnapKit

final class NearUserEmptyView: BaseView {
    
    let categoryStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 0
        return view
    }()
    
    let arroundSesacButton: UIButton = {
        let view = UIButton()
        view.setTitle("주변 새싹", for: .normal)
        view.setTitleColor(.colorGray6, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        return view
    }()
    
    let receivedRequestButton: UIButton = {
        let view = UIButton()
        view.setTitle("받은 요청", for: .normal)
        view.setTitleColor(.colorGray6, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        return view
    }()
    
    let arroundBoundView: UIView = {
        let view = UIView()
        view.backgroundColor = .colorGreen
        return view
    }()
    
    let requestBoundView:UIView = {
        let view = UIView()
        view.backgroundColor = .colorGray2
        return view
    }()
    
    let arroundSesacView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let arroundSesacTableView: UITableView = {
        let view = UITableView()
        
        return view
    }()
    
    let receivedRequestView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let receivedRequestTableView: UITableView = {
        let view = UITableView()
        
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
        /*
         [manView, womanView].forEach {
             genderStackView.addArrangedSubview($0)
         }
         */
        [arroundSesacButton, receivedRequestButton].forEach {
            categoryStackView.addArrangedSubview($0)
        }
        
        arroundSesacView.addSubview(arroundSesacTableView)
        
        receivedRequestView.addSubview(receivedRequestTableView)
        
        [changeStudyButton, refreshButton].forEach {
            searchSectionView.addSubview($0)
        }
        
        [categoryStackView, arroundBoundView, requestBoundView,arroundSesacView, receivedRequestView, searchSectionView].forEach {
            self.addSubview($0)
        }
        
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        
        categoryStackView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        arroundBoundView.snp.makeConstraints { make in
            make.top.equalTo(categoryStackView.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(requestBoundView.snp.leading)
            make.height.equalTo(2)
        }
        
        requestBoundView.snp.makeConstraints { make in
            make.leading.equalTo(categoryStackView.snp.centerX)
            make.trailing.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(arroundBoundView.snp.bottom)
            make.height.equalTo(1)
        }
        
        arroundSesacView.snp.makeConstraints { make in
            make.top.equalTo(arroundBoundView.snp.bottom)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        arroundSesacTableView.snp.makeConstraints { make in
            make.edges.equalTo(arroundSesacView.safeAreaLayoutGuide)
        }
        
        receivedRequestView.snp.makeConstraints { make in
            make.top.equalTo(arroundBoundView.snp.bottom)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        receivedRequestTableView.snp.makeConstraints { make in
            make.edges.equalTo(receivedRequestView.safeAreaLayoutGuide)
        }
        
        searchSectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(48)
        }
        
        changeStudyButton.snp.makeConstraints { make in
            make.verticalEdges.leading.equalTo(searchSectionView.safeAreaLayoutGuide)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalTo(searchSectionView.safeAreaLayoutGuide)
            make.leading.equalTo(changeStudyButton.snp.trailing).offset(8)
            make.width.equalTo(48)
        }
    }
    
    
}
