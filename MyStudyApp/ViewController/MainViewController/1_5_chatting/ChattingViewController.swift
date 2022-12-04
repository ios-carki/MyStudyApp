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
    
    var chat: [Chat] = []
    var myMessage: [String] = []
    
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableSetting()
        sendButtonSetting()
        
        NotificationCenter.default.addObserver(self, selector: #selector(getMessage(notification: )), name: NSNotification.Name("getMessage"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        SocketIOManager.shared.cloaseConnect()
    }
    
    func sendButtonSetting() {
        mainView.sendButton.addTarget(self, action: #selector(sendButtonClikced), for: .touchUpInside)
        
    }
    
    @objc func sendButtonClikced() {
        guard let myText = mainView.userTextView.text else { return }
        modelView.postChat(text: myText, userUID: UserDefaults.standard.string(forKey: "userUID")!) { statusCode, data in
            switch statusCode {
            case 200:
                print("전송 성공")
                self.myMessage.append(data.chat)
                self.mainView.messageTableView.reloadData()
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
    
    @objc func getMessage(notification: NSNotification) {
            
        let chat = notification.userInfo!["chat"] as! String
        let name = notification.userInfo!["name"] as! String
        let createdAt = notification.userInfo!["createdAt"] as! String
        let userID = notification.userInfo!["userId"] as! String
        
        let value = Chat(text: chat, userID: userID, name: name, username: "", id: "", createdAt: createdAt, updatedAt: "", v: 0, ID: "")
        
        self.chat.append(value)
        mainView.messageTableView.reloadData()
        mainView.messageTableView.scrollToRow(at: IndexPath(row: self.chat.count - 1, section: 0), at: .bottom, animated: false)
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
}

extension ChattingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = chat[indexPath.row]
        
        if data.userID == APIKey.userId {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatMyMessageCell.identifier) as? ChatMyMessageCell else { return UITableViewCell() }
            cell.chatTextLabel.text = data.text
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatOtherMessageCell.identifier) as? ChatOtherMessageCell else { return UITableViewCell() }
            cell.chatTextLabel.text = data.text
            
            return cell
        }
    }
    
    
}
