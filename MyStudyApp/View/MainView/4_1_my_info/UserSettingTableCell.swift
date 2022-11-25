//
//  UserSettingTableCell.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/15.
//

import UIKit

import SnapKit

final class UserSettingTableCell: UITableViewCell {
    static let identifier = "userSetting"
    
    //MARK: 성별
    let genderView: UIView = {
        let view = UIView()

        return view
    }()

    let userGenderLabel: UILabel = {
        let view = UILabel()
        view.text = "내 성별"
        view.textColor = .black
        view.font = .systemFont(ofSize: 14)
        return view
    }()

    let genderStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 8
        return view
    }()
    
    let manButton: UIButton = {
        let view = UIButton()
        view.setTitle("남자", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.colorGray4.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    let womanButton: UIButton = {
        let view = UIButton()
        view.setTitle("여자", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.colorGray4.cgColor
        view.layer.cornerRadius = 8
        return view
    }()

    //MARK: 자주하는 스터디
    let mainStudyView: UIView = {
        let view = UIView()

        return view
    }()
    
    let mainStudyLabel: UILabel = {
        let view = UILabel()
        view.text = "자주 하는 스터디"
        view.textColor = .black
        view.font = .systemFont(ofSize: 14)
        return view
    }()

    let inputStudyTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "스터디를 입력해 주세요"
        view.textColor = .black
        return view
    }()

    let textFieldUnderline: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.colorGray3.cgColor
        return view
    }()

    //MARK: 내 번호 검색 허용
    let searchPhoneNumView: UIView = {
        let view = UIView()

        return view
    }()

    let searchPhoneNumLabel: UILabel = {
        let view = UILabel()
        view.text = "내 번호 검색 허용"
        view.textColor = .black
        view.font = .systemFont(ofSize: 14)
        return view
    }()

    let searchPhoneNumSwitch: UISwitch = {
        let view = UISwitch()
        view.isOn = true
        return view
    }()

    //MARK: 상대방 연령대
    let userAgeGroupView: UIView = {
        let view = UIView()
        
        return view
    }()

    let userAgeGroupLabel: UILabel = {
        let view = UILabel()
        view.text = "상대방 연령대"
        view.textColor = .black
        view.font = .systemFont(ofSize: 14)
        return view
    }()

    let exampleAgeGrouplabel: UILabel = {
        let view = UILabel()
        view.text = "테스트라인"
        view.textColor = .black
        view.textColor = .colorGreen
        view.font = .systemFont(ofSize: 14)
        return view
    }()

    let userAgeGroupSlider: UISlider = {
        let view = UISlider()

        return view
    }()
    
    let resignView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let resignButton: UIButton = {
        let view = UIButton()
        view.setTitle("회원탈퇴", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
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
        //뷰 안에 들어갈 콘텐츠
        //MARK: 성별
        [manButton, womanButton].forEach {
            genderStackView.addArrangedSubview($0)
        }

        [userGenderLabel, genderStackView].forEach {
            genderView.addSubview($0)
        }

        //MARK: 자주 하는 스터디
        [mainStudyLabel, inputStudyTextField, textFieldUnderline].forEach {
            mainStudyView.addSubview($0)
        }

        //MARK: 내 번호 검색 허용
        [searchPhoneNumLabel, searchPhoneNumSwitch].forEach {
            searchPhoneNumView.addSubview($0)
        }

        //MARK: 상대방 연령대
        [userAgeGroupLabel, exampleAgeGrouplabel,userAgeGroupSlider].forEach {
            userAgeGroupView.addSubview($0)
        }
        
        //MARK: 회원탈퇴
        resignView.addSubview(resignButton)

        //메인 콘텐츠(뷰들)
        [genderView, mainStudyView, searchPhoneNumView, userAgeGroupView, resignView].forEach {
            contentView.addSubview($0)
        }
        
        genderView.isHidden = true
        mainStudyView.isHidden = true
        searchPhoneNumView.isHidden = true
        userAgeGroupView.isHidden = true
        resignView.isHidden = true
    }
    
    private func setConstraints() {
        genderView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        userGenderLabel.snp.makeConstraints { make in
            make.centerY.equalTo(genderView.safeAreaLayoutGuide)
            make.leading.equalTo(genderView.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(22)
        }
        
        genderStackView.snp.makeConstraints { make in
            make.centerY.equalTo(genderView.safeAreaLayoutGuide)
            make.trailing.equalTo(genderView.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(48)
            make.width.equalTo(120)
        }
        
        //12
        mainStudyView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        mainStudyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(mainStudyView.safeAreaLayoutGuide)
            make.leading.equalTo(mainStudyView.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(22)
        }
        
        inputStudyTextField.snp.makeConstraints { make in
            make.centerY.equalTo(mainStudyView.safeAreaLayoutGuide)
            make.trailing.equalTo(mainStudyView.safeAreaLayoutGuide).offset(-16)
            make.width.equalTo(164)
        }
        
        textFieldUnderline.snp.makeConstraints { make in
            make.trailing.equalTo(mainStudyView.safeAreaLayoutGuide).offset(-16)
            make.bottom.equalTo(mainStudyView.safeAreaLayoutGuide)
            make.height.equalTo(1)
            make.width.equalTo(inputStudyTextField.snp.width)
        }
        
        searchPhoneNumView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        searchPhoneNumLabel.snp.makeConstraints { make in
            make.centerY.equalTo(searchPhoneNumView.safeAreaLayoutGuide)
            make.leading.equalTo(searchPhoneNumView.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(22)
        }
        
        searchPhoneNumSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(searchPhoneNumView.safeAreaLayoutGuide)
            make.trailing.equalTo(searchPhoneNumView.safeAreaLayoutGuide).offset(-16)
        }
        
        userAgeGroupView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }

        userAgeGroupLabel.snp.makeConstraints { make in
            make.top.equalTo(userAgeGroupView.safeAreaLayoutGuide).offset(12)
            make.leading.equalTo(userAgeGroupView.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(22)
        }

        exampleAgeGrouplabel.snp.makeConstraints { make in
            make.centerY.equalTo(userAgeGroupLabel.snp.centerY)
            make.trailing.equalTo(userAgeGroupView.safeAreaLayoutGuide).offset(-16)
        }

        userAgeGroupSlider.snp.makeConstraints { make in
            make.top.equalTo(userAgeGroupLabel.snp.bottom).offset(14)
            make.horizontalEdges.equalTo(userAgeGroupView.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(userAgeGroupView.safeAreaLayoutGuide)
        }
        
        resignView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        resignButton.snp.makeConstraints { make in
            make.centerY.equalTo(resignView.safeAreaLayoutGuide)
            make.leading.equalTo(resignView.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(22)
        }
    }
}
