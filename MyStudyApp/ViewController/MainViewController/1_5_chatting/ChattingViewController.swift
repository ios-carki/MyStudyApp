//
//  ChattingViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/22.
//

import UIKit

import RealmSwift

final class ChattingViewController: UIViewController {
    
    let mainView = ChattingView()
    let modelView = APIService()
    
    var myIdString: String?
    
    var chat: [chatData] = []
    var myMessage: [String] = []
    var oldChatData: [chatData] = []
    
    let localRealm = try! Realm()
    var tasks: Results<UserChatData>! {
        didSet {
            print("렘 데이터 추가됨 테이블뷰 갱신!")
            mainView.messageTableView.reloadData()
        }
    }
    var otherUID: String?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Realm is located at:", localRealm.configuration.fileURL!)
        
        fetchRealm {
            self.fetchChat()
            SocketIOManager.shared.establishConnect()
        }
        naviSetting()
        tableSetting()
        sendButtonSetting()
        myID()
        print("내 id값", myIdString)

        //이벤트 수신
        NotificationCenter.default.addObserver(self, selector: #selector(getMessage(notification: )), name: NSNotification.Name("getMessage"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //뷰가 완전 사라지고나서 소켓 해제
        SocketIOManager.shared.cloaseConnect()
    }
    
    //MARK: 1. DB에서 상대방 UID 필터링해서 가져옴
    private func fetchRealm(_ completion: () -> ()) {
        tasks = localRealm.objects(UserChatData.self)
            .sorted(byKeyPath: "userID")
            .where { $0.userID == otherUID! }
        completion()
        
    }
    
    //네비바 - 스터디 취소, 리뷰등록
    private func naviSetting() {
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "more"), style: .plain, target: self, action: #selector(moreButtonClikced))
        rightMoreButtonSetting()
        
    }
    
    private func rightMoreButtonSetting() {
        let cancelStudy = UIAction(title: "스터디 취소") { action in
            self.modelView.dodgeStudyAPI(otherUID: self.otherUID ?? "error")
        }
        self.navigationItem.rightBarButtonItem?.menu = UIMenu(image: UIImage(named: "more"), options: .displayInline, children: [cancelStudy])
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
                
                //채팅내역 db저장
                let task = UserChatData(chatID: data.ID ?? "chatIDError", userID: data.to ?? "userIDError", chat: data.chat ?? "chatError", createdAt: Date().formatted("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"))
                
                print("추가될 렘 데이터 출력: ", task)
                
                try! self.localRealm.write({
                    self.localRealm.add(task)
                })
                
                //채팅텍스트 누르고 스크롤 최 하단으로 내리기
                //row -> 전체 데이터 - 1
                //index가 0 이면 런타임 오류 발생
                //self.mainView.messageTableView.scrollToRow(at: IndexPath(row: self.tasks.count - 1, section: 0), at: .bottom, animated: false)
                
                //마지막 채팅 시간 저장
                UserDefaults.standard.set(String(Date().formatted("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")), forKey: "lastChatDate")
                //데이터 전송 안되는 지점
                
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
    
    func fetchChat() {
        let lastChat = localRealm.objects(UserChatData.self)
            .filter("userID == '\(UserDefaults.standard.string(forKey: "userUID")!)'")
            .sorted(byKeyPath: "createdAt", ascending: false)
            .first
      
        print("lastChat결과!!!!!!: ", lastChat)
        
        modelView.fetchChat(otherUID: UserDefaults.standard.string(forKey: "userUID")!, lastChatDate: "\(lastChat)") { statusCode, chatData in
            switch statusCode {
            case 200:
                
                self.mainView.messageTableView.reloadData()
                
                return
            default:
                return print("fetchChat error!")
            }
        }
    }
    
    //노티피케이션센터 이벤트 수신
    @objc func getMessage(notification: NSNotification) {
        
        let chatID = notification.userInfo!["ID"] as! String
        let to = notification.userInfo!["to"] as! String
        let from = notification.userInfo!["from"] as! String
        let chat = notification.userInfo!["chat"] as! String
        let createdAt = notification.userInfo!["createdAt"] as! String
         
        //let value = chatData(ID: userID, to: to, from: from, chat: chat, createdAt: createdAt)
        let value = UserChatData(chatID: chatID, userID: to, chat: chat, createdAt: createdAt)
        print("보내는 벨류☎️☎️☎️☎️☎️: ", value)
        
        try! localRealm.write({
            localRealm.add(value)
        })
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
                self.myIdString = data?.uid ?? ""
                print("id받아오기 성공 받은 Id: ", data?.uid ?? "")
                print("저장된 myid: ", self.myIdString!)
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
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let data = chat[indexPath.row]
        let data = tasks[indexPath.row]
//        print("데이터상 내 아이디 값: ", indexPath.row)
//        print("전달받은 내 아이디: ", indexPath.row, myIdString!)
//        print("상대방 id, ", indexPath.row, UserDefaults.standard.string(forKey: "userUID")!)
        UserDefaults.standard.set(myIdString!, forKey: "myID")
        
        print("내 아이디: \(myIdString!)_____ 상대방 아이디: \(data.userID)")
        if data.userID == myIdString! {
           print("같을때 :", data.userID)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatMyMessageCell.identifier) as? ChatMyMessageCell else { return UITableViewCell() }
            cell.chatTextLabel.text = data.chat
            //print("내 버블: ", indexPath.row, myIdString!)
            

            return cell
        } else {
            print("다를때 :", data.userID)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatOtherMessageCell.identifier) as? ChatOtherMessageCell else { return UITableViewCell() }
            cell.chatTextLabel.text = data.chat
            print("상대방 버블: ", indexPath.row, myIdString!)
            
            return cell
        } 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
