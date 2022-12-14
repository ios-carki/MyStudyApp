//
//  APIService.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/12.
//

import Foundation

import Alamofire
import FirebaseAuth
import FirebaseCore


//로그인 Post해서 받은 형태 -> 토큰만 받았기 때문에 토큰 파라미터 하나만 생성
struct Login: Codable {
    let idtoken: String
}

//로그인 데이터 받고나서 진행할 데이터
struct Profile: Codable {
    let user: UserData
}

struct UserData: Codable {
    let _id: String
    let __v: Int
    let uid: String
    let phoneNumber: String
    let email: String
    let FCMtoken: String
    let nick: String
    let birth: String
    let gender: Int
    let study: String
    let comment: [String]
    let reputation: [Int]
    let sesac: Int
    let sesacCollection: [Int]
    let background: Int
    let backgroundCollection: [Int]
    let purchaseToken: [String]
    let transactionId: [String]
    let reviewedBefore: [String]
    let reportedNum: Int
    let reportedUser: [String]
    let dodgepenalty: Int
    let dodgeNum: Int
    let ageMin: Int
    let ageMax: Int
    let searchable: Int
    let createdAt: String
}

//검색 후 받은 데이터
struct SearchUserData: Codable {
    let fromQueueDB: [SearchUserDataFromQueueDB]
    let fromQueueDBRequested: [SearchUserDataFromQueueDB]
    let fromRecommend: [String]
}

//fromQueueDB, fromQueueDBRequested
struct SearchUserDataFromQueueDB: Codable {
    let studylist: [String]
    let reviews: [String]
    let reputation: [Int]
    let uid: String
    let nick: String
    let gender: Int
    let type: Int
    let sesac: Int
    let background: Int
    let long: Double
    let lat: Double
}

struct MyQueueState: Codable {
    let dodged: Int
    let matched: Int
    let reviewed: Int
    let matchedNick: String
    let matchedUid: String
}

struct rateData: Codable {
    let otheruid: String
    let reputation: [Int]
    let comment: String
}

final class APIService {
    
    func signup(phoneNum: String, FCMToken: String, nickName: String, birth: String, email: String, gender: String, completionHandler: @escaping (Int) -> Void) {
        let api = SeSACAPI.signup(phoneNumber: phoneNum, FCMtoken: FCMToken, nick: nickName, birth: birth, email: email, gender: gender)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { response in
            
            completionHandler(response.response?.statusCode ?? 0)
            print("받은 메시지: ", response)
            print("에러코드: ", response.response?.statusCode ?? 0)
        }
        
    }
    
    func login(completionHandler: @escaping (UserData?, Int) -> Void) {
        let api = SeSACAPI.profile
        
        //로그인 후 받는 토큰 제이슨 데이터 디코딩
        AF.request(api.url, method: .get, headers: api.headers).responseDecodable(of: UserData.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(data, response.response?.statusCode ?? 0)
                
                return
            case .failure(_):
                print("로그인 통신 자체 오류 ❌❌❌❌❌❌❌❌❌")
                print(response.response?.statusCode ?? 0)
                //self.getIdToken()
                
                completionHandler(nil, response.response?.statusCode ?? 0)
                
                return
            }
            
        }
        
    }
    
    //MARK: 스터디 함께할 새싹 찾기 요청
    func userQueue(latitude: String, longitude: String, studyList: String, completionHandler: @escaping (Int) -> Void) {
        let api = SeSACAPI.requestSearchSeSAC(lat: latitude, long: longitude, studylist: studyList)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseData { response in
            
            switch response.result {
            case .success(_):
                print("userQueue 요청 성공")
                completionHandler(response.response?.statusCode ?? 0)
                return
            case .failure(_):
                print("userQueue 요청 실패", #function)
                
                return
            }
        }
    }
    
    
    //MARK: 새싹 검색 -> 어노테이션 관련 / 필요한 데이터 -> 좌표값(lat, long), 성별, 캐릭터이미지(sesac)
    func searchSeSAC(latitude: String, longitude: String, completionHandler: @escaping (Int, SearchUserData) -> Void) {
        let api = SeSACAPI.searchSeSAC(lat: latitude, long: longitude)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseDecodable(of: SearchUserData.self) { response in
            
            switch response.result {
            case .success(let data):
                print("검색 성공: ")
                completionHandler(response.response?.statusCode ?? 0, data)
                
                return
            case .failure(_):
                print("에러코드: ", response.response?.statusCode ?? 0)
                
                return
            }
        }
    }
    
    //MARK: 스터디 요청
    func requestStudy(otherUID: String, completionHandler: @escaping (Int) -> Void) {
        let api = SeSACAPI.requestStudy(otheruid: otherUID)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { response in
            
            switch response.result {
            case .success:
                completionHandler(response.response?.statusCode ?? 0)
                
                return
            case .failure(_):
                print("스터디요청 에러")
                
                return
            }
        }
    }
    
    //MARK: 스터디 수락
    func acceptStudy(otherUID: String, completionHandler: @escaping (Int) -> Void) {
        let api = SeSACAPI.acceptStudy(otheruid: otherUID)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { response in
            
            switch response.result {
            case .success:
                completionHandler(response.response?.statusCode ?? 0)
                
                return
            case .failure:
                print("스터디요청 에러")
                
                return
            }
        }
    }
    
    //MARK: 스터디 찾기 중단
    func stopSearchStudyAPI() {
        let api = SeSACAPI.stopSearchStudy
        
        AF.request(api.url, method: .delete, headers: api.headers).responseData { response in
            
            switch response.result {
            case .success:
                print("스터디 찾기 중단 요청 완료!", #function)
                
                return
            case .failure:
                print("스터디 찾기 중단 요청 실패! ❌❌❌❌❌", response.response?.statusCode)
                return
            }
        }
    }
    
    //MARK: 스터디 취소
    func dodgeStudyAPI(otherUID: String, completionHandler: @escaping (Int) -> Void) {
        let api = SeSACAPI.dodgeStudy(otheruid: otherUID)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseData { response in
            switch response.result {
            case .success:
                print("스터디 취소 성공 ✅✅✅✅✅")
                completionHandler(response.response?.statusCode ?? 0)
                return
            case .failure:
                print("스터디 취소 실패 ❌❌❌❌❌: ", response.response?.statusCode)
                
                return
            }
        }
    }
    
    //MARK: 사용자의 매칭상태 확인
    func myQueueState(completionHandler: @escaping (MyQueueState?, Int) -> Void) {
        let api = SeSACAPI.userQueueState
        
        AF.request(api.url, method: .get, headers: api.headers).responseDecodable(of: MyQueueState.self) { response in
            
            switch response.result {
            case .success(let data):
                completionHandler(data, response.response?.statusCode ?? 0)
                return
            case .failure(let errorCode):
                completionHandler(nil, response.response?.statusCode ?? 0)
                
                print("내 상태 확인 에러")
                
                return
            }
        }
    }
    
    //MARK: Chat
    func postChat(text: String, userUID: String, completionHandler: @escaping (Int, chatData) -> Void) {
        let api = SeSACAPI.postChat(chatText: text)
        let chatURL = URL(string: APIKey.url + "/" + APIKey.userId)!//URL(string: URL.makeEndpointURL("/v1/chat/\(userUID)"))!
        
        AF.request(chatURL, method: .post, parameters: api.parameters, headers: api.headers).responseDecodable(of: chatData.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(response.response?.statusCode ?? 0, data)
                
                return
            case .failure(_):
                print("채팅 에러: ", #function)
                print(response.response?.statusCode)
                
                return
            }
        }
    }
    
    func fetchChat(otherUID: String, lastChatDate: String, completionHandler: @escaping (Int, chatData) -> Void) {
        let api = SeSACAPI.fetchChat
        let fetchChatURL = "\(APIKey.url)/\(otherUID)?lastchatDate=\(lastChatDate))"
        
        AF.request(fetchChatURL, method: .get, headers: api.headers).responseDecodable(of: chatData.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(response.response?.statusCode ?? 0, data)
                
                return
            case .failure:
                print("채팅 내역 패치 오류", #function)
                print(response.response?.statusCode)
                return
            }
        }
    }
    
    //MARK: 리뷰 남기기
    func rate(otherUID: String, completionHandler: @escaping (Int) -> Void) {
        let api = SeSACAPI.rate(otheruid: otherUID)
        let rateURL = APIKey.reviewURL + otherUID
        
        AF.request(rateURL, method: .post, headers: api.headers).responseDecodable(of: rateData.self) { response in
            switch response.result {
            case .success:
                completionHandler(response.response?.statusCode ?? 0)
                
                return
            case .failure:
                print("리뷰남기기 실패✅✅✅✅✅✅✅✅", response.response?.statusCode)
                
                return
            }
        }
    }
    
    //MARK: In_App 새싹샵 내 정보 요청
    func shopMyInfo(completionHandler: @escaping (UserData) -> Void) {
        let api = SeSACAPI.shopMyInfo
        
        AF.request(api.url, method: .get, headers: api.headers).responseDecodable(of: UserData.self) { response in
            switch response.result {
            case .success(let data):
                print("새싹샵 유저 정보 불러오기 성공✅✅✅✅✅: ", response.response?.statusCode ?? 0)
                completionHandler(data)
                return
            case .failure:
                print("새싹샵 유저 정보 불러오기 실패❌❌❌❌❌: ", response.response?.statusCode ?? 0)
                return
            }
        }
    }
    
    //MARK: In_App 유저 프로필 새싹, 배경화면 업데이트
    func sesacUpdate(sesac: String?, background: String?, completionHandler: @escaping (Int) -> Void) {
        let api = SeSACAPI.sesacDetail(sesac: sesac ?? "0", background: background ?? "0")
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseDecodable(of: shopItem.self) { response in
            switch response.result {
            case .success:
                print("새싹 디테일 요청 성공✅✅✅✅✅: 상태코드 = ", response.response?.statusCode ?? 0)
                completionHandler(response.response?.statusCode ?? 0)
                
                return
            case .failure:
                print("들어간 API PARAMETERS: ", api.parameters)
                print("들어간 API HEADERS: ", api.headers)
                print("새싹 디테일 요청 실패❌❌❌❌❌: 상태코드 = ", response.response?.statusCode ?? 0)
                completionHandler(response.response?.statusCode ?? 0)
                
                return
            }
        }
    }
    
    //MARK: In_App 새싹 샵 아이템 구매 API
    func shopPurchase(receipt: String, product: String, completionHandler: @escaping (Int) -> Void) {
        let api = SeSACAPI.inAppPurchase(receipt: receipt, product: product)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseData { response in
            switch response.result {
            case .success:
                print("✅✅✅✅✅ 인앱결제 성공 ✅✅✅✅✅")
                completionHandler(response.response?.statusCode ?? 0)
                
                return
            case .failure:
                print("❌❌❌❌❌ 인앱결제 성공 ❌❌❌❌❌")
                completionHandler(response.response?.statusCode ?? 0)
                return
            }
        }
    }
    
    func getIdToken() {
        
        guard let currentUser = Auth.auth().currentUser else { return }
        currentUser.getIDTokenForcingRefresh(true) { idToken, error in
          if let error = error {
            // Handle error
            return;
          }
            print("갱신성공!❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️")
            print("갱신 id토큰: ", idToken)
            UserDefaults.standard.set(idToken!, forKey: "idtoken")
            
            print("갱신된 id토큰으로 재 로그인 시도")
            
        }
    }
    
    func getIdTokenLogin(completion: @escaping () -> Void) {
        
        guard let currentUser = Auth.auth().currentUser else { return }
        currentUser.getIDTokenForcingRefresh(true) { idToken, error in
          if let error = error {
            // Handle error
            return;
          }
            print("갱신성공!❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️")
            print("갱신 id토큰: ", idToken)
            UserDefaults.standard.set(idToken!, forKey: "idtoken")
            
            print("갱신된 id토큰으로 재 로그인 시도")
            completion()
        }
    }
}
