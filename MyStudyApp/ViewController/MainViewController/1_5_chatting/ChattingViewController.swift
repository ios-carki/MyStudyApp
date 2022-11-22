//
//  ChattingViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/22.
//

import UIKit

final class ChattingViewController: UIViewController {
    
    let mainView = ChattingView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
