//
//  ChattingViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/22.
//

import UIKit

final class ChattingViewController: UIViewController {
    
    let mainView = ChattingView()
    let modelView = APIService()
    
    var myIdString: String?
    
    var chat: [chatData] = []
    var myMessage: [String] = []
    var oldChatData: [chatData] = []
    
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchChat()
        tableSetting()
        sendButtonSetting()
        myID()
        
        //이벤트 수신
        NotificationCenter.default.addObserver(self, selector: #selector(getMessage(notification: )), name: NSNotification.Name("getMessage"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //뷰가 완전 사라지고나서 소켓 해제
        SocketIOManager.shared.cloaseConnect()
    }
    
    func sendButtonSetting() {
        mainView.sendButton.addTarget(self, action: #selector(sendButtonClikced), for: .touchUpInside)
        mainView.userTextView.text = ""
        
    }
    
    @objc func sendButtonClikced() {
        //guard let myText = mainView.userTextView.text else { return }
        modelView.postChat(text: mainView.userTextView.text ?? "", userUID: UserDefaults.standard.string(forKey: "userUID")!) { statusCode, data in
            switch statusCode {
            case 200:
                print("전송 성공")
                print("받은 데이터 >>>>>>>>>>>> ", data)
                self.myMessage.append(data.chat ?? "")
                self.chat.append(data)
                self.mainView.messageTableView.reloadData()
                
                //채팅텍스트 누르고 스크롤 최 하단으로 내리기
                //row -> 전체 데이터 - 1
                //index가 0 이면 런타임 오류 발생
                self.mainView.messageTableView.scrollToRow(at: IndexPath(row: self.myMessage.count - 1, section: 0), at: .bottom, animated: false)
                
                //마지막 채팅 시간 저장
                UserDefaults.standard.set(String(Date().formatted("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")), forKey: "lastChatDate")
                //데이터 전송 안되는 지점
                return
            case 201:
                print("전송 201")
                return
            case 401:
                print("전송 401")
                return
            case 406:
                print("전송 406")
                return
            case 500:
                print("전송 500")
                return
            case 501:
                print("전송 501")
                return
            default:
                print("전송 default")
                return
            }
        }
    }
    
    func fetchChat() {
        modelView.fetchChat(otherUID: UserDefaults.standard.string(forKey: "userUID")!) { statusCode, chatData in
            switch statusCode {
            case 200:
                self.chat.append(chatData)
                self.mainView.messageTableView.reloadData()
//                self.mainView.messageTableView.scrollToRow(at: IndexPath(row: self.oldChatData.count - 1, section: 0), at: .bottom, animated: false)
                
                //이전 데이터 먼저 받고나서 소켓 연결
                SocketIOManager.shared.establishConnect()
                
                return
            default:
                return print("fetchChat error!")
            }
        }
    }
    
    //노티피케이션센터 이벤트 수신
    @objc func getMessage(notification: NSNotification) {

//        let chat = notification.userInfo!["chat"] as! String
//        let name = notification.userInfo!["name"] as! String
//        let createdAt = notification.userInfo!["createdAt"] as! String
//        let userID = notification.userInfo!["userId"] as! String
        
        let userID = notification.userInfo!["ID"] as! String
        let to = notification.userInfo!["to"] as! String
        let from = notification.userInfo!["from"] as! String
        let chat = notification.userInfo!["chat"] as! String
        let createdAt = notification.userInfo!["createdAt"] as! String
         
        let value = chatData(ID: userID, to: to, from: from, chat: chat, createdAt: createdAt)

        self.chat.append(value)
        mainView.messageTableView.reloadData()
//        mainView.messageTableView.scrollToRow(at: IndexPath(row: self.chat.count - 1, section: 0), at: .bottom, animated: false)
    }
    
    func tableSetting() {
        mainView.messageTableView.register(ChatAlertCell.self, forCellReuseIdentifier: ChatAlertCell.identifier)
        //mainView.messageTableView.register(ChatDateCell.self, forCellReuseIdentifier: ChatDateCell.identifier)
        mainView.messageTableView.register(ChatMyMessageCell.self, forCellReuseIdentifier: ChatMyMessageCell.identifier)
        mainView.messageTableView.register(ChatOtherMessageCell.self, forCellReuseIdentifier: ChatOtherMessageCell.identifier)
        
        mainView.messageTableView.dataSource = self
        mainView.messageTableView.delegate = self
        mainView.messageTableView.allowsSelection = false
        mainView.messageTableView.separatorStyle = .none
        mainView.messageTableView.rowHeight = UITableView.automaticDimension
    }
    
    //매칭쪽에서 구현해서 값전달 해야됨
    func myID() {
        modelView.login { data, statusCode in
            switch statusCode {
            case 200:
                self.myIdString = data?._id
                return
            default:
                print("id받아오기 오류")
                self.myIdString = "error"
            }
        }
    }
}

extension ChattingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = chat[indexPath.row]
        
        if data.ID == myIdString {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatOtherMessageCell.identifier) as? ChatOtherMessageCell else { return UITableViewCell() }
            cell.chatTextLabel.text = data.chat
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatMyMessageCell.identifier) as? ChatMyMessageCell else { return UITableViewCell() }
            cell.chatTextLabel.text = data.chat

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
