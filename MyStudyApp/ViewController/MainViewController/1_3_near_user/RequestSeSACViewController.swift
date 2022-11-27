//
//  ReceivedSeSACViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/27.
//

import UIKit

final class RequestSeSACViewController: UIViewController {
    
    private let mainView = RequestSeSACView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
