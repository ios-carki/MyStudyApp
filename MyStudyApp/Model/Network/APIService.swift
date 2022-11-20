//
//  APIService.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/12.
//

import Foundation

import Alamofire

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
    
    func login(completionHandler: @escaping (String?, Int?) -> Void) {
        let api = SeSACAPI.profile
        
        //로그인 후 받는 토큰 제이슨 데이터 디코딩
        AF.request(api.url, method: .get, headers: api.headers).responseDecodable(of: UserData.self) { response in
            
            switch response.result {
                
            case .success(let data):
                completionHandler(data.nick, nil)
            case .failure(_):
                print(response.response?.statusCode)
                completionHandler(nil, response.response?.statusCode)
            }
            
        }
        
    }
    
    //MARK: 새싹 찾기 요청
    func requestSearchSeSAC(latitude: String, longitude: String, stydyList: [String], completionHandler: @escaping () -> ()) {
        let api = SeSACAPI.requestSearchSeSAC(lat: latitude, long: longitude, studylist: stydyList)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { response in
            
            
        }
    }
    
    //MARK: 새싹 검색
    func searchSeSAC(latitude: String, longitude: String, completionHandler: @escaping (Int) -> Void) {
        let api = SeSACAPI.searchSeSAC(lat: latitude, long: longitude)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { response in
            
            completionHandler(response.response?.statusCode ?? 0)
            print("에러코드: ", response.response?.statusCode ?? 0)
            
        }
    }
}
