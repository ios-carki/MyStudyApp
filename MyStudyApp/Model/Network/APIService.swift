//
//  APIService.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/12.
//

import Foundation

import Alamofire

final class APIService {
    
//    func signup(name: String, email: String, password: String, completionHandler: @escaping (Int) -> Void) {
//        let api = SeSACAPI.signup(userName: name, email: email, password: password)
//
//        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { response in
//
//            completionHandler(response.response?.statusCode ?? 0)
//            print(response)
//            print(response.response?.statusCode)
//
//        }
//    }
    
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
}
