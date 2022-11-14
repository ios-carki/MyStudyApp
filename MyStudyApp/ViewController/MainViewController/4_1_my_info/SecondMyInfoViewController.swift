//
//  SecondMyInfoViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/14.
//

import UIKit

final class SecondMyInfoViewController: UIViewController {
    
    let mainView = SecondMyInfoView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
