//
//  WriteReviewViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/15.
//

import UIKit

final class WriteReviewViewController: UIViewController {
    
    let mainView = WriteReviewView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
