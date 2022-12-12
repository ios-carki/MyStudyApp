//
//  UserChatData.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/12.
//

import Foundation

import RealmSwift

class UserChatData: Object {
    @Persisted var chatID: String
    @Persisted var userID: String
    @Persisted var myID: String
    @Persisted var chat: String
    @Persisted var createdAt: String
    
    convenience init(chatID: String, userID: String, myID: String, chat: String, createdAt: String) {
        self.init()
        self.chatID = chatID
        self.userID = userID
        self.myID = myID
        self.chat = chat
        self.createdAt = createdAt
    }
}
