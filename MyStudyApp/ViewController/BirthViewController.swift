//
//  BirthViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/08.
//

import UIKit

final class BirthViewController: UIViewController {
    
    let mainView = BirthView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
