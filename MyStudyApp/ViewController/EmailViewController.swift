//
//  EmailViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/08.
//

import UIKit

final class EmailViewController: UIViewController {
    
    let mainView = EmailView()
    
    override func loadView() {
        view = mainView
    }
}
