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
    //새싹 캐릭터
    static let sesacDataSet: [(sesacImageTuple: String, sesacNameTuple: String, sesacDetailTuple: String)] = [
        ("0", "기본 새싹", "새싹을 대표하는 기본 식물입니다. 다른 새싹들과 함께 하는 것을 좋아합니다."),
        ("1", "튼튼 새싹", "잎이 하나 더 자라나고 튼튼해진 새나라의 새싹으로 같이 있으면 즐거워집니다."),
        ("2", "민트 새싹", "호불호의 대명사! 상쾌한 향이 나서 허브가 대중화된 지역에서 많이 자랍니다."),
        ("3", "퍼플 새싹", "감정을 편안하게 쉬도록 하며 슬프고 우울한 감정을 진정시켜주는 멋진 새싹입니다."),
        ("4", "골드 새싹", "화려하고 멋있는 삶을 살며 돈과 인생을 플렉스 하는 자유분방한 새싹입니다.")
    ]
    
    //새싹 배경
    static let backgroundDataSet: [(backgroundImageTuple: String, imageNameTuple: String, imageDetailTuple: String)] = [
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
    
    //인앱 번들ID - 새싹 캐릭터
    static let productIdentifiers: Set<String> = [
        "com.memolease.sesac1.sprout1",
        "com.memolease.sesac1.sprout2",
        "com.memolease.sesac1.sprout3",
        "com.memolease.sesac1.sprout4"
    ]
}

class userSelectedData {
    static let shared = userSelectedData()
    
    var sesac: String?
    var background: String?
    
    private init() { }
}
