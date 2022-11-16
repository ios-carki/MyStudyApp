//
//  MainPlusFriendsViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/16.
//

import UIKit

final class MainPlusFriendsViewController: UIViewController {
    
    private let mainView = MainPlusFriendsView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
