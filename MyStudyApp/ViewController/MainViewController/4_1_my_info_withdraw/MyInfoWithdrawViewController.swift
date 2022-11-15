//
//  MyInfoWithdrawViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/15.
//

import UIKit

final class MyInfoWithdrawViewController: UIViewController {
    
    let mainView = MyInfoWithdrawView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelButtonSetting()
    }
    
    func cancelButtonSetting() {
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
    }
    
    @objc func cancelButtonClicked() {
        self.dismiss(animated: false)
    }
}
