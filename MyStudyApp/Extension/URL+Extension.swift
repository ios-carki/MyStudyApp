//
//  URL+Extension.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/12.
//

import Foundation

extension URL {
    static let baseURL = "http://api.sesac.co.kr:1210"
    
    //MARK: 회원가입
    static func makeSignupEndPoint(_ endPoint: String) -> String {
        return baseURL + endPoint
    }
    
    //MARK: 새싹 찾기 요청
    static func makeRequestSearchSesacEndPoint(_ endPoint: String) -> String {
        return baseURL + endPoint
    }
    
    //MARK: 새싹 검색
    
    static func makeSearchSesacEndPoint(_ endPoint: String) -> String {
        return baseURL + endPoint
    }
    
    /*
     static func makeEndPointString(_ endPoint: String) -> String {
         return baseURL + endPoint
     }
     */
    
}
