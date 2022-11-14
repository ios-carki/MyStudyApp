//
//  SecondMyInfoViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/14.
//

import UIKit

struct cellData {
    var selected = Bool()
    var expandCell = [UITableViewCell]()
}

final class SecondMyInfoViewController: UIViewController {
    
    let mainView = SecondMyInfoView()
    
    var tableViewData = [cellData]()
    var hiddenSection = Set<Int>()
    
    override func loadView() {
        view = mainView
        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //데이터
        
        view.backgroundColor = .white
        tableSetting()
    }
    
    func tableSetting() {
        mainView.detailTableView.register(SecondMyInfoDetailTableView.self, forCellReuseIdentifier: SecondMyInfoDetailTableView.identifier)
        
        tableViewData = [cellData(selected: false, expandCell: [UITableViewCell()])]
        
        mainView.detailTableView.delegate = self
        mainView.detailTableView.dataSource = self
    }
}

extension SecondMyInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].selected {
            return tableViewData[section].expandCell.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondMyInfoDetailTableView.identifier, for: indexPath) as? SecondMyInfoDetailTableView else { return UITableViewCell() }
//
//        cell.userNicklabel.text = "김새싹"
        
        /*
         cell.textLabel?.text = self.tableViewData[indexPath.section][indexPath.row]
             
         */
        
        if indexPath.row == 0 { // 기본 섹션
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondMyInfoDetailTableView.identifier, for: indexPath) as? SecondMyInfoDetailTableView else { return UITableViewCell() }
            
            return cell
        } else { //펼쳐진 데이터
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondMyInfoExpandTableView.identifier, for: indexPath) as? SecondMyInfoExpandTableView else { return UITableViewCell() }
            
            return cell
        }
    }
    
    
}
