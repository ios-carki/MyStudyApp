//
//  ChattingMoreViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/15.
//

import UIKit

final class ChattingMoreViewController: UIViewController {
    
    let mainView = ChattingMoreView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSetting()
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
        
    }
    
    @objc func cancelButtonClikced() {
        
    }
    
    @objc func reviewButtonClikced() {
        
    }
}
