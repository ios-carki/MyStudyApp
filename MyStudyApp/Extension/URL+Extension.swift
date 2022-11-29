//
//  URL+Extension.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/12.
//

import Foundation

extension URL {
    //MARK: Base URL
    static let baseURL = "http://api.sesac.co.kr:1210"
    
    static func makeEndpointURL(_ endPoint: String) -> String {
        return baseURL + endPoint
    }
}
//
//    //MARK: 회원가입 & 로그인
//    static let userURL = "/v1/user"
//
//    //MARK: 새싹 찾기 요청
//    static let queueURL = "/v1/queue"
//
//    //MARK: 주변 새싹 탐색
//    static let searchURL = "/v1/queue/search"
//
//    //MARK: 스터디 요청
//    static let studyRequestURL = "/v1/queue/studyrequest"
    
//    //MARK: 회원가입
//    static func makeSignupEndPoint(_ endPoint: String) -> String {
//        return baseURL + endPoint
//    }
//
//    //MARK: 새싹 찾기 요청
//    static func makeRequestSearchSesacEndPoint(_ endPoint: String) -> String {
//        return baseURL + endPoint
//    }
//
//    //MARK: 새싹 검색
//
//    static func makeSearchSesacEndPoint(_ endPoint: String) -> String {
//        return baseURL + endPoint
//    }
//
//    //MARK: 스터디 요청
//    static func requestStudy(_ endPoint: String) -> String {
//        return baseURL + endPoint
//    }
    
//}
