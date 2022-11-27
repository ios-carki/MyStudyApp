//
//  ReceiveViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/26.
//

import UIKit

final class ReceiveViewController: UIViewController {
    private let mainView = ReceiveView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
