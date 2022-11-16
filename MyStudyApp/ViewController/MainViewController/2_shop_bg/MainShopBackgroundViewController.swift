//
//  MainShopBackgroundViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/16.
//

import UIKit

final class MainShopBackgroundViewController: UIViewController {
    
    private let mainView = MainShopBackgroundView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
