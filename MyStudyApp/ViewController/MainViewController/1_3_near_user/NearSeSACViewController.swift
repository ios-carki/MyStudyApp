//
//  NearSeSACViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/27.
//

import UIKit
import CoreLocation

final class NearSeSACViewController: UIViewController {
    
    private let mainView = NearSeSACView()
    let modelView = APIService()
    
    var receivedLocation: CLLocation!
    
    var arroundUserData: [SearchUserDataFromQueueDB] = []
    var userNickName: [String] = []
    var userBackgroundImage: [Int] = []
    var userSeSACImage: [Int] = []
    var userUID: [String] = []
    
    var cardStatus: [Bool] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableSetting()
        dataSetting()
    }
    
    func tableSetting() {
        mainView.arroundSesacTableView.register(CardViewTableCell.self, forCellReuseIdentifier: CardViewTableCell.identifier)
        
        mainView.arroundSesacTableView.delegate = self
        mainView.arroundSesacTableView.dataSource = self
    }
    
    func dataSetting() {
        searchAPI(lat: UserDefaults.standard.string(forKey: "currentLocationLat")!, long: UserDefaults.standard.string(forKey: "currentLocationLong")!)
    }
    
    func searchAPI(lat: String, long: String) {
        modelView.searchSeSAC(latitude: lat, longitude: long) { (statusCode, data) in
            let apiData = data.fromQueueDB
            
            switch statusCode {
            case 200:
                print("새싹 검색 성공🤢🤢🤢🤢🤢🤢🤢🤢")
                //서버 데이터 받아오기
                self.arroundUserData = apiData
                for i in 0..<apiData.count {
                    self.userNickName.append(apiData[i].nick)
                    self.userSeSACImage.append(apiData[i].sesac)
                    self.userBackgroundImage.append(apiData[i].background)
                    self.userUID.append(apiData[i].uid)
                    
                    //카드뷰 상태
                    self.cardStatus.append(false)
                    self.mainView.arroundSesacTableView.reloadData()
                    
                }
                print("데이터 목록: 🦍🦍🦍🦍🦍🦍🦍🦍", apiData)
                
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

extension NearSeSACViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: 카드뷰 펼치기
    @objc func toggleBool(gesture: CustomTapGestureRecognizer) {
        cardStatus[gesture.targetView?.tag ?? 0] = !cardStatus[gesture.targetView?.tag ?? 0]
        mainView.arroundSesacTableView.reloadRows(at: [IndexPath(row: gesture.targetView?.tag ?? 0, section: 0)], with: .none)
    }
    
    //MARK: 요청하기 버튼
    @objc func requestButtonClikced(gesture: CustomTapGestureRecognizer) {
        let vc = NearUserPopupViewController()
        vc.userUID = userUID[gesture.targetView?.tag ?? 0]
        vc.modalPresentationStyle = .overCurrentContext
        
        self.present(vc, animated: false)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arroundUserData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //MARK: 빈 화면이 나올시 분기처리도 해야되니 UIView로 만들어놓은 emptyView -> 테이블뷰 셀로 만들어서 유저데이터 카운트가 0 이면 해당셀 보여주기로 하기
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardViewTableCell.identifier) as? CardViewTableCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        //요청하기 버튼 뷰
        cell.requestButtonView.isHidden = false
        cell.requestButtonView.backgroundColor = .colorError
        cell.requestButton.text = "요청하기"
        cell.requestButton.textColor = .white
        
        var userBackground: backgroundImage = .background
        var userChar: backgroundImage = .userImage
        
        cell.cardBackgroundImage.image = UIImage(named: "\(userBackground.rawValue)\(String(userBackgroundImage[indexPath.row]))")
        cell.cardCharImage.image = UIImage(named: "\(userChar.rawValue)\(String(userSeSACImage[indexPath.row]))")
        cell.nickNameLabel.text = userNickName[indexPath.row]
        
        //MARK: 새싹 카드뷰 펼치기
        //유저 각 셀의 닉네임 영역에 태그값 부여
        cell.nickNameView.tag = indexPath.row
        
        //해당 셀 닉네임 영역 선택 시
        let cardViewTapped = CustomTapGestureRecognizer(target: self, action: #selector(self.toggleBool(gesture: )))
        cardViewTapped.targetView = cell.nickNameView
        cell.nickNameView.addGestureRecognizer(cardViewTapped)
        
        if cardStatus[indexPath.row] {
            cell.expandImage.image = UIImage(named: "up_arrow")
            cell.titleView.isHidden = false
            cell.reviewView.isHidden = false
        } else {
            cell.expandImage.image = UIImage(named: "down_arrow")
            cell.titleView.isHidden = true
            cell.reviewView.isHidden = true
        }
        
        //MARK: 새싹 스터디 요청하기 버튼
        //요청하기 영역에 태그값 부여
        cell.requestButtonView.tag = indexPath.row
        
        //요청하기 버튼 클릭 시
        let requestButtonClikced = CustomTapGestureRecognizer(target: self, action: #selector(self.requestButtonClikced(gesture: )))
        requestButtonClikced.targetView = cell.requestButtonView
        cell.requestButtonView.addGestureRecognizer(requestButtonClikced)
        
        
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
        if cardStatus[indexPath.row] { //펼쳐짐
            return 504
        } else { //접힘
            return 268//292
        }
    }

}

class CustomTapGestureRecognizer: UITapGestureRecognizer {
    var targetView: UIView?
    var targetLabel: UILabel?
}
