//
//  ShopSeSACViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/28.
//

import UIKit

final class ShopSeSACViewController: UIViewController {
    
    private let mainView = ShopSeSACView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionSetting()
    }
    
    func collectionSetting() {
        mainView.sesacCollectionView.register(ShopSeSACCell.self, forCellWithReuseIdentifier: ShopSeSACCell.identifier)
        
        mainView.sesacCollectionView.delegate = self
        mainView.sesacCollectionView.dataSource = self
    }
}

extension ShopSeSACViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ShopData.sesacDataSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopSeSACCell.identifier, for: indexPath) as? ShopSeSACCell else { return UICollectionViewCell() }
        
        cell.sesacCharImage.image = UIImage(named: "shop_sesac_face_" + ShopData.sesacDataSet[indexPath.item].sesacImageTuple)
        cell.charNameLabel.text = ShopData.sesacDataSet[indexPath.item].sesacNameTuple
        cell.charDetailLabel.text = ShopData.sesacDataSet[indexPath.item].sesacDetailTuple
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userSelectedData.shared.sesac = "\(indexPath.row)"
        NotificationCenter.default.post(name: .sesacNotiName, object: userSelectedData.shared.sesac)
        
        
    }
}

