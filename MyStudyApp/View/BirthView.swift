//
//  BirthView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/08.
//

import UIKit

import SnapKit

final class BirthView: BaseView {
    
    let inputBirthLabel: UILabel = {
        let view = UILabel()
        view.text = "생년월일을 알려주세요"
        view.font = .systemFont(ofSize: 20)
        view.textAlignment = .center
        return view
    }()
    
    let dateStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 0
        return view
    }()
    
    let yearView: UIView = {
        let view = UIView()
        return view
    }()
    
    let yearButton: UIButton = {
        let view = UIButton()
        view.setTitle("1990", for: .normal)
        view.setTitleColor(.colorGray7, for: .normal)
        view.contentHorizontalAlignment = .left
        return view
    }()
    
    let yearBoundaryLine: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.colorGray3.cgColor
        return view
    }()
    
    let yearLabel: UILabel = {
        let view = UILabel()
        view.text = "년"
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    let monthView: UIView = {
        let view = UIView()
        return view
    }()
    
    let monthButton: UIButton = {
        let view = UIButton()
        view.setTitle("1", for: .normal)
        view.setTitleColor(.colorGray7, for: .normal)
        view.contentHorizontalAlignment = .left
        return view
    }()
    
    let monthBoundaryLine: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.colorGray3.cgColor
        return view
    }()
    
    let monthLabel: UILabel = {
        let view = UILabel()
        view.text = "월"
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    let dayView: UIView = {
        let view = UIView()
        return view
    }()
    
    let dayButton: UIButton = {
        let view = UIButton()
        view.setTitle("1", for: .normal)
        view.setTitleColor(.colorGray7, for: .normal)
        view.contentHorizontalAlignment = .left
        return view
    }()
    
    let dayBoundaryLine: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.colorGray3.cgColor
        return view
    }()
    
    let dayLabel: UILabel = {
        let view = UILabel()
        view.text = "일"
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
        
        [yearButton, yearLabel].forEach {
            yearView.addSubview($0)
        }
        
        [monthButton, monthLabel].forEach {
            monthView.addSubview($0)
        }
        
        [dayButton, dayLabel].forEach {
            dayView.addSubview($0)
        }
        
        [yearView, monthView, dayView].forEach {
            dateStackView.addArrangedSubview($0)
        }
        
        [inputBirthLabel, dateStackView, yearBoundaryLine, monthBoundaryLine, dayBoundaryLine, nextButton].forEach {
            self.addSubview($0)
        }
        
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        
        inputBirthLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(96)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(32)
        }
        
        dateStackView.snp.makeConstraints { make in
            make.top.equalTo(inputBirthLabel.snp.bottom).offset(80)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        yearButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(yearView.safeAreaLayoutGuide)
            make.leading.equalTo(yearView.safeAreaLayoutGuide).offset(28)
            make.trailing.equalTo(yearLabel.snp.leading)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(yearView.safeAreaLayoutGuide)
            make.width.equalTo(15)
        }
        
        monthButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(monthView.safeAreaLayoutGuide)
            make.leading.equalTo(monthView.safeAreaLayoutGuide).offset(28)
            make.trailing.equalTo(monthLabel.snp.leading)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(monthView.safeAreaLayoutGuide)
            make.width.equalTo(yearLabel.snp.width)
        }
        
        dayButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(dayView.safeAreaLayoutGuide)
            make.leading.equalTo(dayView.safeAreaLayoutGuide).offset(28)
            make.trailing.equalTo(dayLabel.snp.leading)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(dayView.safeAreaLayoutGuide)
            make.trailing.equalTo(dayView.safeAreaLayoutGuide)
            make.width.equalTo(yearLabel.snp.width)
        }
        
        yearBoundaryLine.snp.makeConstraints { make in
            make.top.equalTo(dateStackView.snp.bottom)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(yearLabel.snp.leading)
            make.height.equalTo(1)
        }
        
        monthBoundaryLine.snp.makeConstraints { make in
            make.top.equalTo(dateStackView.snp.bottom)
            make.leading.equalTo(yearBoundaryLine.snp.trailing).offset(42)
            make.trailing.equalTo(monthLabel.snp.leading)
            make.height.equalTo(1)
        }
        
        dayBoundaryLine.snp.makeConstraints { make in
            make.top.equalTo(dateStackView.snp.bottom)
            make.leading.equalTo(monthBoundaryLine.snp.trailing).offset(42)
            make.trailing.equalTo(dayLabel.snp.leading)
            make.height.equalTo(1)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(dateStackView.snp.bottom).offset(72)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
}
