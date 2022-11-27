//
//  MenuCollection.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/26.
//

import UIKit

import SnapKit

final class MenuCollection: NSObject {
    let viewData = NearUserView()
    var menuNameArr = ["주변 새싹", "받은 요청"]
    var pager: UICollectionView!
    var highlightView: UIView!
    var view: UIView!
    
    private let firstIndexPath = IndexPath(item: 0, section: 0)
}

extension MenuCollection: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuNameArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: indexPath) as? MenuCell else { return UICollectionViewCell() }
        cell.setTitle(title: menuNameArr[indexPath.row])
        cell.menuLabel.textAlignment = .center
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / CGFloat(menuNameArr.count)
        
        return CGSize(width: width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MenuCell else { return }
        view = PagerCell().pageView
        
        pager.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        UIView.animate(withDuration: 0.1) {
            self.highlightView.snp.remakeConstraints { make in
                make.top.equalTo(collectionView.snp.bottom)
                make.width.equalTo(cell.snp.width)
                make.height.equalTo(3)
            }
            self.view.layoutIfNeeded()
        }
        
    }
    
}
