//
//  ReceivedSeSACViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/27.
//

import UIKit

final class RequestSeSACViewController: UIViewController {
    
    private let mainView = NearSeSACView()
    private let modelView = APIService()
    
    private var receivedRequest: [SearchUserDataFromQueueDB] = []
    private var userNickName: [String] = []
    private var userBackgroundImage: [Int] = []
    private var userSeSACImage: [Int] = []
    private var userUID: [String] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviSetting()
        dataSetting()
    }
    
    private func naviSetting() {
        mainView.arroundSesacTableView.register(CardViewTableCell.self, forCellReuseIdentifier: CardViewTableCell.identifier)
        
        mainView.arroundSesacTableView.delegate = self
        mainView.arroundSesacTableView.dataSource = self
    }
    
    func dataSetting() {
        searchAPI(lat: UserDefaults.standard.string(forKey: "currentLocationLat")!, long: UserDefaults.standard.string(forKey: "currentLocationLong")!)
    }
    
    func searchAPI(lat: String, long: String) {
        modelView.searchSeSAC(latitude: lat, longitude: long) { (statusCode, data) in
            let apiData = data.fromQueueDBRequested
            
            switch statusCode {
            case 200:
                print("새싹 검색 성공🤢🤢🤢🤢🤢🤢🤢🤢")
                //서버 데이터 받아오기
                self.receivedRequest = apiData
                for i in 0..<apiData.count {
                    self.userNickName.append(apiData[i].nick)
                    self.userSeSACImage.append(apiData[i].sesac)
                    self.userBackgroundImage.append(apiData[i].background)
                    self.userUID.append(apiData[i].uid)
                    
                    //카드뷰 상태
//                    self.cardStatus.append(false)
                    self.mainView.arroundSesacTableView.reloadData()
                    
                }
                print("데이터 목록: 🦍🦍🦍🦍🦍🦍🦍🦍", data)
                
                return
            case 401:
                print("FireBase Token Error 토큰 갱신 ㄱ ㄱ")
                self.modelView.getIdToken()
                
                return
            case 406:
                print("미가입 회원")
                
                return
            case 500:
                print("서버 에러 - FCMtoken 확인")
                
                return
            case 501:
                print("클라이언트 에러 - 얼럿 띄워야 되나?")
                
                return
            default:
                print("기본")
            }
        }
    }
}

extension RequestSeSACViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedRequest.count
    }
    
    //MARK: 수락하기 버튼
    @objc func acceptButtonClikced(gesture: CustomTapGestureRecognizer) {
        let vc = RequestPopupViewController()
        vc.userUID = userUID[gesture.targetView?.tag ?? 0]
        vc.modalPresentationStyle = .overCurrentContext
        
        self.present(vc, animated: false)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardViewTableCell.identifier) as? CardViewTableCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        //MARK: 수락하기 버튼 뷰
        //design
        cell.requestButtonView.isHidden = false
        cell.requestButtonView.backgroundColor = .colorSuccess
        cell.requestButton.text = "수락하기"
        cell.requestButton.textColor = .white
        
        //function
        cell.requestButtonView.tag = indexPath.row
        let requestButtonClikced = CustomTapGestureRecognizer(target: self, action: #selector(self.acceptButtonClikced(gesture: )))
        requestButtonClikced.targetView = cell.requestButtonView
        cell.requestButtonView.addGestureRecognizer(requestButtonClikced)
        
        var userBackground: backgroundImage = .background
        var userChar: backgroundImage = .userImage
        
        cell.cardBackgroundImage.image = UIImage(named: "\(userBackground.rawValue)\(String(userBackgroundImage[indexPath.row]))")
        cell.cardCharImage.image = UIImage(named: "\(userChar.rawValue)\(String(userSeSACImage[indexPath.row]))")
        cell.nickNameLabel.text = userNickName[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            if cardStatus { //펼쳐짐
//                return 504
//            } else { //접힘
//                return 268//292
//            }
//            //return 292
//        } else {
//            if indexPath.row == 3 {
//                return 80
//            }
//        }
//        return 64
//        return 268
//        if cardStatus[indexPath.row] { //펼쳐짐
//            return 504
//        } else { //접힘
//            return 268//292
//        }
        
        return 268
    }


}
