//
//  URL+Extension.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/12.
//

import Foundation

extension URL {
    
    static func makeEndpointURL(_ endPoint: String) -> String {
        return APIKey.baseURL + endPoint
    }
    
}
