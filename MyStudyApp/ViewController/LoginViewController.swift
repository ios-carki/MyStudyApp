//
//  LoginViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/07.
//

import UIKit

final class LoginViewController: UIViewController {
    
    let mainView = LoginView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}
