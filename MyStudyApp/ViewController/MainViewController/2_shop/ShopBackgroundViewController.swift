//
//  ShopBackgroundViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/28.
//

import UIKit

final class ShopBackgroundViewController: UIViewController {
    private let mainView = ShopBackgroundView()
    private let tabManView = ShopTabmanView()
    
    //API Request
    private let modelView = APIService()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableSetting()
    }
    
    func tableSetting() {
        mainView.backgroundTable.register(ShopBackgroundCell.self, forCellReuseIdentifier: ShopBackgroundCell.identifier)
        
        mainView.backgroundTable.delegate = self
        mainView.backgroundTable.dataSource = self
        
        mainView.backgroundTable.rowHeight = 165
    }
    
}

extension ShopBackgroundViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShopData.backgroundImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShopBackgroundCell.identifier) as? ShopBackgroundCell else { return UITableViewCell() }
        cell.backgroundImage.image = UIImage(named: ShopData.backgroundImage[indexPath.row])
        cell.backgroundNameLabel.text = ShopData.backgroundImageName[indexPath.row]
        cell.detailLabel.text = ShopData.backgroundImageDetail[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            userSelectedData.shared.background = "1"
            
            break
        case 1:
            userSelectedData.shared.background = "2"
            
            break
        case 2:
            userSelectedData.shared.background = "3"
            
            break
        case 3:
            userSelectedData.shared.background = "4"
            
            break
        case 4:
            userSelectedData.shared.background = "5"
            
            break
        case 5:
            userSelectedData.shared.background = "6"
            
            break
        case 6:
            userSelectedData.shared.background = "7"
            
            break
        case 7:
            userSelectedData.shared.background = "8"
            
            break
        case 8:
            userSelectedData.shared.background = "9"
            
            break
        default:
            print("잘못된 인덱스 선택")
        }
        
        print("결과: ", userSelectedData.shared.background)
        NotificationCenter.default.post(name: NSNotification.Name("background"), object: userSelectedData.shared.background)
    }
    
}
