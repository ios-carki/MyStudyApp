//
//  User.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/11.
//

import Foundation

class User {
    static let shared = User()
    
    var phoneNumber: String?
    var FCMtoken: String?
    var nick: String?
    var birth: String?
    var email: String?
    var gender: Int?
    
    private init() { }
}
