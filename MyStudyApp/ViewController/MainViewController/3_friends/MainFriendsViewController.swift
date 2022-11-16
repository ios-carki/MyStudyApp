//
//  MainFriendsViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/16.
//

import UIKit

final class MainFriendsViewController: UIViewController {
    
    private let mainView = MainFriendsView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
