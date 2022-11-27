//
//  NearUserViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/26.
//

import UIKit

enum VcId{
    case near
    case receive
}

final class NearUserViewController: UIViewController {
    
    private let mainView = NearUserView()
    private let menuData = MenuCollection()
    
    lazy var vcArray: [UIViewController] = [self.VCInstance(name: .near), self.VCInstance(name: .receive)]
    private var direction: Int = 0
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewSetting()
        naviSetting()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let firstIndexPath = IndexPath(item: 0, section: 0) // delegate 호출
        mainView.tabMenuCollectionView.selectItem(at: firstIndexPath, animated: false, scrollPosition: .right)
        menuData.collectionView(mainView.tabMenuCollectionView, didSelectItemAt: firstIndexPath)
    }
    
    func naviSetting() {
        self.title = "새싹 찾기"
    }
    
    func collectionViewSetting() {
        menuData.pager = mainView.pagerCollectionView
        menuData.highlightView = mainView.highlightBar
        
        mainView.tabMenuCollectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifier)
        mainView.tabMenuCollectionView.delegate = menuData
        mainView.tabMenuCollectionView.dataSource = menuData
        
        mainView.pagerCollectionView.register(PagerCell.self, forCellWithReuseIdentifier: PagerCell.identifier)
        mainView.pagerCollectionView.delegate = self
        mainView.pagerCollectionView.dataSource = self
    }
    
    private func VCInstance(name: VcId) -> UIViewController {
        switch name {
        case .near:
            let nearVC = NearSeSACViewController()
            
            return nearVC
        default:
            let receiveVC = ReceiveViewController()
            
            return receiveVC
            
        }
    }
}

extension NearUserViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let frameVC = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PagerCell.identifier, for: indexPath) as? PagerCell else { return UICollectionViewCell() }
        var vc = vcArray[indexPath.row]
        vc.view.frame = frameVC
        cell.pageView = vc.view
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(collectionView.frame.width), height: CGFloat(collectionView.frame.height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView)
        if velocity.x < 0 { // -: 오른쪽에서 왼쪽 <<<
            direction = -1
            
        } else if velocity.x > 0 { // +: 왼쪽에서 오른쪽 >>>
            direction = 1
            
        } else { }
        UIView.animate(withDuration: 0.1) { [weak self] in
            self!.mainView.highlightBar.transform = CGAffineTransform(translationX: scrollView.contentOffset.x / 2, y: 0)
            self!.mainView.highlightBar.layoutIfNeeded()
        }
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = Int(targetContentOffset.pointee.x / mainView.tabMenuCollectionView.frame.width)
        let indexPath = IndexPath(item: index, section: 0)
        
        if direction > 0 { // >>>> 스와이프하면 스크롤은 중앙으로
            mainView.tabMenuCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
        } else { // <<<< 스와이프하면 스크롤은 왼쪽으로
            mainView.tabMenuCollectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        }
        
        mainView.tabMenuCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
        //viewIndex.onNext(indexPath.row)

    }
    
    
}
