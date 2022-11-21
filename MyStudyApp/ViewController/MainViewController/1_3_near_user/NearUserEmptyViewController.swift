//
//  NearUserEmptyViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/20.
//

import UIKit

final class NearUserEmptyViewController: UIViewController {
    
    let mainView = NearUserEmptyView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviSetting()
        changeStudyButtonSetting()
    }
    
    func naviSetting() {
        self.title = "새싹 찾기"
    }
    
    func changeStudyButtonSetting() {
        mainView.changeStudyButton.addTarget(self, action: #selector(changeStudyButtonClicked), for: .touchUpInside)
    }
    
    @objc func changeStudyButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}
