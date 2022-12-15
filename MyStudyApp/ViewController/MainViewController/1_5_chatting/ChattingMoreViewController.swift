//
//  ChattingMoreViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/15.
//

import UIKit

import Toast

final class ChattingMoreViewController: UIViewController {
    
    let mainView = ChattingMoreView()
    
    var otherUID: String?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSetting()
        
        print("전달받은 UID: ", otherUID ?? "")
    }
    
    private func buttonSetting() {
        let reportGesture = UITapGestureRecognizer(target: self, action: #selector(reportButtonClikced))
        let cancelGesture = UITapGestureRecognizer(target: self, action: #selector(cancelButtonClikced))
        let reviewGesture = UITapGestureRecognizer(target: self, action: #selector(reviewButtonClikced))
        
        mainView.reportView.addGestureRecognizer(reportGesture)
        mainView.cancelView.addGestureRecognizer(cancelGesture)
        mainView.reviewView.addGestureRecognizer(reviewGesture)
    }
    
    @objc func reportButtonClikced() {
        view.makeToast("지원하지 않는 기능입니다.", position: .top)
    }
    
    @objc func cancelButtonClikced() {
        let vc = CancelMatchViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.otherUID = otherUID ?? "값전달 에러✅✅✅✅✅"
        
        self.present(vc, animated: false)
    }
    
    @objc func reviewButtonClikced() {
        
    }
}
