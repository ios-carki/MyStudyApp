//
//  GenderViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/09.
//

import UIKit

final class GenderViewController: UIViewController {
    
    let mainView = GenderView()
    
    var gender: User = User()
    
    //manView, womanView에 텝 제스쳐 줄것
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backGroundViewSetting()
        viewSetting()
        nextButtonSetting()
    }
    
    //이거 쓰면 모든 뷰객체 선택때마다 실행됨
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        print("배경 선택됨")
//        mainView.manView.backgroundColor = .white
//        mainView.womanView.backgroundColor = .white
//        mainView.nextButton.backgroundColor = .colorGray6
//
//        gender.gender = -1
//    }
    func backGroundViewSetting() {
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(backGroundTapped))
        mainView.backGroundView.addGestureRecognizer(backTapGesture)
    }
    
    @objc func backGroundTapped() {
        print("백그라운드 탭됨")
        gender.gender = -1
        
        mainView.manView.backgroundColor = .white
        mainView.womanView.backgroundColor = .white
        mainView.nextButton.backgroundColor = .colorGray6
    }
    
    func viewSetting() {
        let manViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(manViewTapped))
        let womanViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(womanViewTapped))
        
        mainView.manView.addGestureRecognizer(manViewTapGesture)
        mainView.womanView.addGestureRecognizer(womanViewTapGesture)
    }
    
    func nextButtonSetting() {
        mainView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    @objc func nextButtonClicked() {
        
        if gender.gender == 0 || gender.gender == 1 {
            print("성별데이터 있음")
            ///네트워크 통신 시작.
            print("완성된 유저 데이터: ", gender)
        } else {
            print("성별데이터 없음")
            view.makeToast("성별을 선택해주세요.", position: .top)
        }
    }
    
    @objc func manViewTapped() {
        mainView.manView.backgroundColor = .colorWhiteGreen
        mainView.womanView.backgroundColor = .white
        mainView.nextButton.backgroundColor = .colorGreen
        
        //var gender: User = User()
        gender.gender = 1
        print("유저가 설정한 성별: ", gender.gender)
        print("현재 유저 데이터 상태: ", gender)
    }
    
    @objc func womanViewTapped() {
        mainView.manView.backgroundColor = .white
        mainView.womanView.backgroundColor = .colorWhiteGreen
        mainView.nextButton.backgroundColor = .colorGreen
        
        //var gender: User = User()
        gender.gender = 0
        print("유저가 설정한 성별: ", gender.gender)
        print("현재 유저 데이터 상태: ", gender)
    }
}
