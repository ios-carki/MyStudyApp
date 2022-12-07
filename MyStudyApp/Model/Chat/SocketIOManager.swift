//
//  SocketIOManager.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/03.
//

import Foundation

import SocketIO

final class SocketIOManager {
    static let shared = SocketIOManager()
    
    //서버와 메시지를 주고 받기 위한 클래스
    var manager: SocketManager!
    
    var socket: SocketIOClient!
    
    private init() {
        manager = SocketManager(socketURL: URL(string: APIKey.socket)!, config: [
            //.log(true),
            .extraHeaders([
                "idtoken": UserDefaults.standard.string(forKey: "idtoken")!,
                "Content-Type": "application/x-www-form-urlencoded"
            ])
        ])
        
        //세부 링크
        socket = manager.defaultSocket //-> 슬래쉬로 표현
        
        //연결
        socket.on(clientEvent: .connect) { data, ack in
            print("SOCKET IS CONNECTED", data, ack)
        }
        
        //연결 해제
        socket.on(clientEvent: .disconnect) { data, ack in
            print("SOCKET IS DISCONNECTED", data, ack)
        }
        
        //이벤트 수신
        socket.on("sesac") { dataArray, ack in
            print("SESAC RECEIVED", dataArray, ack)
            
            //인코딩
//            let data = dataArray[0] as! NSDictionary
//            let chat = data["chat"] as! String
//            let name = data["to"] as! String
//            let userId = data["ID"] as! String
//            let createdAt = data["createdAt"] as! String
            
//            print("CHECK >>>", chat, name, createdAt)
            let data = dataArray[0] as! NSDictionary
            let userID = data["ID"] as! String
            let to = data["to"] as! String
            let from = data["from"] as! String
            let chat = data["chat"] as! String
            let createdAt = data["createdAt"] as! String
            
            //이벤트 수신값 전달
            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: ["ID": userID, "to": to, "from": from, "chat": chat, "createdAt": createdAt])
        }
    }
    
    func establishConnect() {
        socket.connect()
        print("소켓 연결됨 🟢🟢🟢🟢🟢")
    }
    
    func cloaseConnect() {
        socket.disconnect()
        print("소켓 연결 해제됨 🔴🔴🔴🔴🔴")
    }
}
