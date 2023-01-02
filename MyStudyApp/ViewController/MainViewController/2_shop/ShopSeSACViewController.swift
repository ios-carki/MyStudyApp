//
//  ShopSeSACViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/28.
//

import StoreKit
import UIKit

final class ShopSeSACViewController: UIViewController {
    
    private let mainView = ShopSeSACView()
    
    //inApp
    var productArray = Array<SKProduct>() //인앱 상품 정보
    var product: SKProduct? //구매할 상품
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionSetting()
        requestProductData()
    }
    
    func collectionSetting() {
        mainView.sesacCollectionView.register(ShopSeSACCell.self, forCellWithReuseIdentifier: ShopSeSACCell.identifier)
        
        mainView.sesacCollectionView.delegate = self
        mainView.sesacCollectionView.dataSource = self
    }
    
    //상품 조회 매서드 - 아이폰에 카드 등록 안됐을때를 확인
    //canMakePayments -> 유저가 카드를 등록 했는지, 어린이들 유해 콘텐츠 확인용
    func requestProductData() {
        if SKPaymentQueue.canMakePayments() {
            print("인앱 결제 가능")
            let request = SKProductsRequest(productIdentifiers: ShopData.productIdentifiers)
            request.delegate = self //SKProductsRequestDelegate
            request.start() //인앱 상품 조회
        } else {
            print("In App Purchase Not Enabled")
        }
    }
    
    //구매버튼 클릭
    func purchaseButtonClikced() {
        let payment = SKPayment(product: product!)
        SKPaymentQueue.default().add(payment)
        SKPaymentQueue.default().add(self) //SKPaymentTransactionObserver
    }
    
    func receiptValidation(transaction: SKPaymentTransaction, productIdentifier: String) {
        // SandBox: “https://sandbox.itunes.apple.com/verifyReceipt”
        // iTunes Store : “https://buy.itunes.apple.com/verifyReceipt”
       
        //구매 영수증 정보
        let receiptFileURL = Bundle.main.appStoreReceiptURL
        let receiptData = try? Data(contentsOf: receiptFileURL!)
        let receiptString = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
       
        print(receiptString)
        //거래 내역(transaction)을 큐에서 제거
        SKPaymentQueue.default().finishTransaction(transaction)
        
    }
}

extension ShopSeSACViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    @objc func priceButtonClikced(gesture: CustomTapGestureRecognizer) {
        print("\(gesture.targetLabel?.tag) 번째 레이블 클릭됨")
        product
        purchaseButtonClikced()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ShopData.sesacDataSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopSeSACCell.identifier, for: indexPath) as? ShopSeSACCell else { return UICollectionViewCell() }
        
        cell.sesacCharImage.image = UIImage(named: "shop_sesac_face_" + ShopData.sesacDataSet[indexPath.item].sesacImageTuple)
        cell.charNameLabel.text = ShopData.sesacDataSet[indexPath.item].sesacNameTuple
        cell.charDetailLabel.text = ShopData.sesacDataSet[indexPath.item].sesacDetailTuple
        
        
        
        //가격 버튼 클릭 관련
        cell.priceLabel.tag = indexPath.row
        
        let priceLabelTapped = CustomTapGestureRecognizer(target: self, action: #selector(self.priceButtonClikced(gesture:)))
        priceLabelTapped.targetLabel = cell.priceLabel
        cell.priceLabel.isUserInteractionEnabled = true
        cell.priceLabel.addGestureRecognizer(priceLabelTapped)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userSelectedData.shared.sesac = "\(indexPath.row)"
        NotificationCenter.default.post(name: .sesacNotiName, object: userSelectedData.shared.sesac)
        
        
    }
}

//MARK: InApp EX
extension ShopSeSACViewController: SKProductsRequestDelegate {
    //인앱 상품 정보 조회
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        
        if products.count > 0 {
            for i in products {
                productArray.append(i)
                product = i
                
                //앱스토어 커넥트에 등록된 정보 제공
                print(i.localizedTitle, i.price, i.priceLocale, i.localizedDescription)
            }
        } else {
            print("No Product Found") //계약 업데이트 안됐을때, 유료 계약 X, Capabilities X
        }
    }
}

extension ShopSeSACViewController: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                print("Transaction Approved. \(transaction.payment.productIdentifier)")
                receiptValidation(transaction: transaction, productIdentifier: transaction.payment.productIdentifier)
            case .failed:
                print("Transaction Failed")
                SKPaymentQueue.default().finishTransaction(transaction)
                
            default:
                break
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        print("removedTransactions")
    }
}
