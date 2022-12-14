//
//  ShopTapmanViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/28.
//

import StoreKit
import UIKit

import Tabman
import Pageboy

final class ShopTapmanViewController: TabmanViewController {
    
    private let mainView = ShopTabmanView()
    
    //API Request
    private let modelView = APIService()
    
    //Tabman
    private var viewControllers: Array<UIViewController> = [ShopSeSACViewController(), ShopBackgroundViewController()]
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviSetting()
        pageBoySetting()
        buttonSetting()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(shopSeSACNoti), name: .sesacNotiName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(shopBackgroundNoti), name: .NotiName, object: nil)
        sesacInfoAPI()
    }
    
    @objc func shopSeSACNoti(_ notification: Notification) {
        guard let imageData = notification.object as? String else { return }
        
        mainView.cardCharImage.image = UIImage(named: "shop_sesac_face_" + imageData)
    }
    
    @objc func shopBackgroundNoti(_ notification: Notification) {
        guard let imageData = notification.object as? String else { return }
        
        mainView.cardBackgroundImage.image = UIImage(named: "shop_sesac_background_" + imageData)
    }
    
    func naviSetting() {
        navigationItem.title = "새싹샵"
    }
    
    func buttonSetting() {
        mainView.saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
    }
    
    @objc func saveButtonClicked() {
        userInfoUpdateAPI()
    }
    
    //새싹 정보요청
    func sesacInfoAPI() {
        modelView.shopMyInfo { data in
            
            print("유저 캐릭터 정보 상태: 새싹이 = \(data.sesac), 배경 = \(data.background)")
//            self.mainView.cardCharImage.image = UIImage(named: "shop_sesac_background_" + String(data.sesac + 1))
            self.mainView.cardBackgroundImage.image = UIImage(named: "shop_sesac_background_" + String(data.sesac + 1))
            
        }
    }
    
    func userInfoUpdateAPI() {
        print("저장하기 버튼 눌림!✅✅✅✅✅✅")
        modelView.sesacUpdate(sesac: userSelectedData.shared.sesac, background: userSelectedData.shared.background) { statusCode in
            switch statusCode {
            case 200:
                print("상태코드 200 선택한 캐릭터, 배경 적용 ✅✅✅")
                
                break
            case 201:
                print("상태코드 201 토스트메시지 pop ✅✅✅")
                self.view.makeToast("구매가 필요한 아이템이 있어요.", position: .bottom)
                break
            default:
                
                return
            }
        }
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
        
        addBar(bar, dataSource: self, at: .custom(view: mainView.shopTabBarView, layout: nil))
    }
    
    //인앱API
//    func purchaseAPI() {
//        modelView.shopPurchase(receipt: <#T##String#>, product: <#T##String#>, completionHandler: <#T##(Int) -> Void#>)
//    }
}

//MARK: Tabman EX
extension ShopTapmanViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
            switch index {
            case 0:
                return TMBarItem(title: "새싹")
                
            case 1:
                return TMBarItem(title: "배경")
                
            default:
                let title = "Page\(index)"
                return TMBarItem(title: title)
            }
    }
}
