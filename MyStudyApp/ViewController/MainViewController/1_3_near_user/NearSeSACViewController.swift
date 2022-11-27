//
//  NearSeSACViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/26.
//

import UIKit

final class NearSeSACViewController: UIViewController {
    private let mainView = NearSeSACView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
    }
}
