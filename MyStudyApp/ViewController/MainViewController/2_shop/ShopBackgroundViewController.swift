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
        return ShopData.backgroundDataSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShopBackgroundCell.identifier) as? ShopBackgroundCell else { return UITableViewCell() }
        
        cell.backgroundImage.image = UIImage(named: "shop_sesac_background_" +  ShopData.backgroundDataSet[indexPath.row].0)
        cell.backgroundNameLabel.text = ShopData.backgroundDataSet[indexPath.row].1
        cell.detailLabel.text = ShopData.backgroundDataSet[indexPath.row].2
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userSelectedData.shared.background = "\(indexPath.row + 1)"
        
        print("결과: ", userSelectedData.shared.background)
        NotificationCenter.default.post(name: .NotiName, object: userSelectedData.shared.background)
    }
    
}
