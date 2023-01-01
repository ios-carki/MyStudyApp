//
//  ShopData.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/29.
//

import Foundation

struct shopItem: Codable {
    let sesac: Int
    let background: Int
    
}

//SeSAC_Shop -> 인앱 리스트 리터럴 데이터
class ShopData {
    static let backgroundDataSet: [(backgroundImageTuple: String, imageNameTuple: String, imageDetailTuple: String)] = [
        //(backgroundImage, Name, Detail)
        ("1", "하늘 공원", "새싹들을 많이 마주치는 매력적인 하늘 공원입니다."),
        ("2", "씨티 뷰", "창밖으로 보이는 도시 야경이 아름다운 공간입니다."),
        ("3", "밤의 산책로", "어둡지만 무섭지 않은 조용한 산책로입니다."),
        ("4", "낮의 산책로", "즐겁고 가볍게 걸을 수 있는 산책로입니다."),
        ("5", "연극 무대", "연극의 주인공이 되어 연기를 펼칠 수 있는 무대입니다."),
        ("6", "라틴 거실", "모노톤의 따스한 감성의 거실로 편하게 쉴 수 있는 공간입니다."),
        ("7", "홈트방", "집에서 운동을 할 수 있도록 기구를 갖춘 방입니다."),
        ("8", "뮤지션 작업실", "여러가지 음악 작업을 할 수 있는 작업실입니다."),
        ("9", "서재", "조용하게 혼자만의 공부를 할 수 있는 서재입니다.")
    ]
}

class userSelectedData {
    static let shared = userSelectedData()
    
    var sesac: String?
    var background: String?
    
    private init() { }
}
