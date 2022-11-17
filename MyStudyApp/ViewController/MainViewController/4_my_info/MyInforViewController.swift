//
//  MyInforViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/14.
//

import UIKit

final class MyInfoViewController: UIViewController {
    
    let mainView = MyInfoView()
    
    let user = User.shared
    
    let infoLableData: [String] = [UserDefaults.standard.string(forKey: "nick") ?? "닉네임을 설정해주세요.", "공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정", "이용약관"]
    let infoIconData: [String] = ["profile_img", "megaphone", "questionmark.circle", "ellipsis.bubble", "bell", "doc.text"]
    
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviSetting()
        tableSetting()
    }
    
    func naviSetting() {
        title = "내정보"
    }
    
    func tableSetting() {
        mainView.infoTableView.register(MyInfoCustomTableView.self, forCellReuseIdentifier: MyInfoCustomTableView.identifier)
        
        mainView.infoTableView.delegate = self
        mainView.infoTableView.dataSource = self
    }
}

extension MyInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoLableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyInfoCustomTableView.identifier, for: indexPath) as? MyInfoCustomTableView else { return UITableViewCell()
        }
        
        if indexPath.row > 0 {
            cell.iconImage.image = UIImage(systemName: infoIconData[indexPath.row])
            cell.infoLabel.text = infoLableData[indexPath.row]
        } else {
            cell.iconImage.image = UIImage(named: infoIconData[indexPath.row])
            cell.infoLabel.text = infoLableData[indexPath.row]
            cell.infoLabel.font = .boldSystemFont(ofSize: 16)
            cell.sideIcon.image = UIImage(systemName: infoIconData[0])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.row) {
        case 0:
            firstIndexFunc()
        case 1:
            print("1번 로우")
        case 2:
            print("2번 로우")
        case 3:
            print("3번 로우")
        case 4:
            print("4번 로우")
        case 5:
            print("5번 로우")
        default:
            print("6번 로우")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row > 0 {
            return 74
        } else {
            return 96
        }
    }
    
    func firstIndexFunc() {
        let vc = SecondMyInfoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
