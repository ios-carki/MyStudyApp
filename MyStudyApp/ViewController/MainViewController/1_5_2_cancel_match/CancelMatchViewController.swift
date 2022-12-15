//
//  CancelMatchViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/15.
//

import UIKit

final class CancelMatchViewController: UIViewController {
    
    let mainView = MyInfoWithdrawView()
    let modelView = APIService()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetting()
        buttonSetting()
    }
    
    private func viewSetting() {
        mainView.signLabel.text = "스터디를 취소하겠습니까?"
        mainView.messageLabel.text = "스터디를 취소하시면 패널티가 부과됩니다"
        mainView.messageLabel.textColor = .black
    }
    
    private func buttonSetting() {
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        mainView.okButton.addTarget(self, action: #selector(okButtonClikced), for: .touchUpInside)
    }
    
    @objc func cancelButtonClicked() {
        self.dismiss(animated: false)
    }
    
    @objc func okButtonClikced() {
        
    }
}
