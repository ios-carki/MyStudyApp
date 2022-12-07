//
//  Chat.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/03.
//

import Foundation

struct chatData: Codable {
    let ID, to, from, chat, createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case ID = "_id"
        case to
        case from
        case chat
        case createdAt
    }
}
