//
//  SplashViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/17.
//

import UIKit

final class SplashViewController: UIViewController {
    
    let mainView = SplashView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.splashControl()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationSetting()
    }
    
    func navigationSetting() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func splashControl() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
