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
    
    var cardStatus = false
    
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
            
            switch statusCode {
            case 200:
                print("새싹 검색 성공🤢🤢🤢🤢🤢🤢🤢🤢")
                //서버 데이터 받아오기
                self.arroundUserData = data
                for i in 0..<data.count {
                    self.userNickName.append(data[i].nick)
                    self.userSeSACImage.append(data[i].sesac)
                    self.userBackgroundImage.append(data[i].background)
                    self.mainView.arroundSesacTableView.reloadData()
                    
                }
                print("데이터 목록: 🦍🦍🦍🦍🦍🦍🦍🦍", data)
            case 401:
                print("FireBase Token Error 토큰 갱신 ㄱ ㄱ")
                self.modelView.getIdToken()
            case 406:
                print("미가입 회원")
                
            case 500:
                print("서버 에러 - FCMtoken 확인")
                
            case 501:
                print("클라이언트 에러 - 얼럿 띄워야 되나?")
            default:
                print("기본")
            }
        }
    }
}

extension NearSeSACViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arroundUserData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardViewTableCell.identifier) as? CardViewTableCell else { return UITableViewCell () }
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
        return 268
    }

}
