//
//  NickNameViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/08.
//

import UIKit

final class NickNameViewController: UIViewController {
    
    let mainView = NickNameView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}

