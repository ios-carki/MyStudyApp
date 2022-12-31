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

class ShopData {
    static let backgroundImage: [String] = ["shop_sesac_background_1", "shop_sesac_background_2", "shop_sesac_background_3", "shop_sesac_background_4", "shop_sesac_background_5", "shop_sesac_background_6", "shop_sesac_background_7", "shop_sesac_background_8", "shop_sesac_background_9"]
    static let backgroundImageName: [String] = ["하늘 공원", "씨티 뷰", "밤의 산책로", "낮의 산책로", "연극 무대", "라틴 거실", "홈트방", "뮤지션 작업실", "서재"]
    static let backgroundImageDetail: [String] =
    ["새싹들을 많이 마주치는 매력적인 하늘 공원입니다.",
    "창밖으로 보이는 도시 야경이 아름다운 공간입니다.",
     "어둡지만 무섭지 않은 조용한 산책로입니다.",
     "즐겁고 가볍게 걸을 수 있는 산책로입니다.",
     "연극의 주인공이 되어 연기를 펼칠 수 있는 무대입니다.",
     "모노톤의 따스한 감성의 거실로 편하게 쉴 수 있는 공간입니다.",
     "집에서 운동을 할 수 있도록 기구를 갖춘 방입니다.",
     "여러가지 음악 작업을 할 수 있는 작업실입니다.",
     "조용하게 혼자만의 공부를 할 수 있는 서재입니다."
    ]
}

class userSelectedData {
    static let shared = userSelectedData()
    
    var sesac: String?
    var background: String?
    
    private init() { }
}
