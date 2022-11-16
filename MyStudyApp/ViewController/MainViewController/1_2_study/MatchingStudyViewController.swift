//
//  MatchingStudyViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/16.
//

import UIKit

final class MatchingStudyViewController: UIViewController {
    
    private let mainView = MatchingStudyView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviSetting()
    }
    
    func naviSetting() {
        
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        //서치바 크기 구해서 백버튼 모든 기기가 동일한 사이즈로 보이도록 구상하기
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: width - 80, height: 0))
        searchBar.placeholder = "띄워쓰기로 복수 입력이 가능해요."
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
        
        let backBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow"), style: .done, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
}
