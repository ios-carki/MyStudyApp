//
//  MainMapViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/16.
//

import UIKit

final class MainMapViewController: UIViewController {
    
    private let mainView = MainMapView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        floatingButtonSetting()
        //naviSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        //naviSetting()
    }
    
    func naviSetting() {
//        let backBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow"), style: .plain, target: self, action: nil)
//        backBarButtonItem.tintColor = .black
//        navigationItem.hidesBackButton = true
//        self.navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    func floatingButtonSetting() {
        mainView.floationButton.addTarget(self, action: #selector(floatingSearchClicked), for: .touchUpInside)
    }
    
    @objc func floatingSearchClicked() {
        let vc = MatchingStudyViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
