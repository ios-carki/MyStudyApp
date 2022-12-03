//
//  NearUserEmptyViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/20.
//

import UIKit

import Tabman
import Pageboy

final class TabManViewController: TabmanViewController {
    
    let mainView = TabManView()
    let modelView = APIService()
    
    private var viewControllers: Array<UIViewController> = [NearSeSACViewController(), RequestSeSACViewController()]
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviSetting()
        pageBoySetting()
//        changeStudyButtonSetting()
    }
    
    func naviSetting() {
        self.navigationController?.navigationBar.tintColor = .black
        
        self.navigationItem.title = "새싹 찾기"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "찾기 중단", style: .plain, target: self, action: #selector(stopSearchButtonClikced))
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    @objc func stopSearchButtonClikced() {
        modelView.stopSearchStudyAPI()
        UserDefaults.standard.set(2, forKey: "matchingStatus")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func pageBoySetting() {
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.backgroundView.style = .blur(style: .light)
        
        //메뉴버튼
        bar.buttons.customize { button in
            button.tintColor = .colorGray6
            button.selectedTintColor = .colorGreen
            button.font = .systemFont(ofSize: 14)
            button.selectedFont = .boldSystemFont(ofSize: 14)
        }
        
        //인디케이터
        bar.indicator.weight = .custom(value: 3)
        bar.indicator.tintColor = .colorGreen
        
        bar.layout.transitionStyle = .snap
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        
        
        addBar(bar, dataSource: self, at: .custom(view: mainView.tabBarView, layout: nil))
    }
}


extension TabManViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "주변 새싹")
        case 1:
            return TMBarItem(title: "받은 요청")
        default:
            let title = "Page\(index)"
            return TMBarItem(title: title)
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return nil
    }
    
}
