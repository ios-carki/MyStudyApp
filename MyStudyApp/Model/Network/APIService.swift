//
//  APIService.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/12.
//

import Foundation

import Alamofire
import FirebaseAuth
import FirebaseCore


//로그인 Post해서 받은 형태 -> 토큰만 받았기 때문에 토큰 파라미터 하나만 생성
struct Login: Codable {
    let idtoken: String
}

//로그인 데이터 받고나서 진행할 데이터
struct Profile: Codable {
    let user: UserData
}

struct UserData: Codable {
    let _id: String
    let __v: Int
    let uid: String
    let phoneNumber: String
    let email: String
    let FCMtoken: String
    let nick: String
    let birth: String
    let gender: Int
    let study: String
    let comment: [String]
    let reputation: [Int]
    let sesac: Int
    let sesacCollection: [Int]
    let background: Int
    let backgroundCollection: [Int]
    let purchaseToken: [String]
    let transactionId: [String]
    let reviewedBefore: [String]
    let reportedNum: Int
    let reportedUser: [String]
    let dodgepenalty: Int
    let dodgeNum: Int
    let ageMin: Int
    let ageMax: Int
    let searchable: Int
    let createdAt: String
}

//검색 후 받은 데이터
struct SearchUserData: Codable {
    let fromQueueDB: [SearchUserDataFromQueueDB]
    let fromQueueDBRequested: [SearchUserDataFromQueueDB]
    let fromRecommend: [String]
}

//fromQueueDB, fromQueueDBRequested
struct SearchUserDataFromQueueDB: Codable {
    let studylist: [String]
    let reviews: [String]
    let reputation: [Int]
    let uid: String
    let nick: String
    let gender: Int
    let type: Int
    let sesac: Int
    let background: Int
    let long: Double
    let lat: Double
}

final class APIService {
    
    func signup(phoneNum: String, FCMToken: String, nickName: String, birth: String, email: String, gender: String, completionHandler: @escaping (Int) -> Void) {
        let api = SeSACAPI.signup(phoneNumber: phoneNum, FCMtoken: FCMToken, nick: nickName, birth: birth, email: email, gender: gender)
        
        print("URL검사: ", api.url)
        print("phoneNum검사: ", phoneNum)
        print("FCMToken검사: ", FCMToken)
        print("nickName검사: ", nickName)
        print("birth검사: ", birth)
        print("email검사: ", email)
        print("gender검사: ", gender)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { response in
            
            completionHandler(response.response?.statusCode ?? 0)
            print("받은 메시지: ", response)
            print("에러코드: ", response.response?.statusCode ?? 0)
        }
        
    }
    
    /*
     헷갈리는 점
     로그인 요청이 유저 데이터를 갖고오는건지
     아니면
     로그인 통신을 하고 다시 프로파일 통신을 해서
     원하는 데이터를 갖고오는건지
     */
    
    func login(completionHandler: @escaping (String?, Int) -> Void) {
        let api = SeSACAPI.profile
        
        let test: String?
        
        
        //로그인 후 받는 토큰 제이슨 데이터 디코딩
        AF.request(api.url, method: .get, headers: api.headers).responseDecodable(of: UserData.self) { response in
            
            
            switch response.result {
                
            case .success(let data):
                completionHandler(data.nick, response.response?.statusCode ?? 0)
            case .failure(_):
                print("로그인 통신 자체 오류 ❌❌❌❌❌❌❌❌❌")
                print(response.response?.statusCode ?? 0)
                self.getIdToken()
                
                completionHandler(nil, response.response?.statusCode ?? 0)
                
            }
            
        }
        
    }
    
    //MARK: 새싹 찾기 요청
    func requestSearchSeSAC(latitude: String, longitude: String, stydyList: [String], completionHandler: @escaping () -> ()) {
        let api = SeSACAPI.requestSearchSeSAC(lat: latitude, long: longitude, studylist: stydyList)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { response in
            
            
        }
    }
    
    //MARK: 새싹 검색 -> 어노테이션 관련 / 필요한 데이터 -> 좌표값(lat, long), 성별, 캐릭터이미지(sesac)
    //handler: (상태코드 Int, 좌표값 - 위도 Double, 좌표값 - 경도 Double, 성별 Int, 캐릭터 이미지 Int)
    func searchSeSAC(latitude: String, longitude: String, completionHandler: @escaping (Int, [SearchUserDataFromQueueDB]) -> Void) {
        let api = SeSACAPI.searchSeSAC(lat: latitude, long: longitude)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseDecodable(of: SearchUserData.self) { response in
            
            switch response.result {
            case .success(let data):
                print("검색 성공: ")
                completionHandler(response.response?.statusCode ?? 0, data.fromQueueDB)
            case .failure(_):
                print("에러코드: ", response.response?.statusCode ?? 0)
            }
//            completionHandler(response.response?.statusCode ?? 0, response.result.lat)
            print("에러코드: ", response.response?.statusCode ?? 0)
            
        }
    }
    
    func getIdToken() {
        
        guard let currentUser = Auth.auth().currentUser else { return }
        currentUser.getIDTokenForcingRefresh(true) { idToken, error in
          if let error = error {
            // Handle error
            return;
          }
            print("갱신성공!❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️")
            print("갱신 id토큰: ", idToken)
            UserDefaults.standard.set(idToken!, forKey: "idtoken")
            
            print("갱신된 id토큰으로 재 로그인 시도")
            
        }
    }
}
