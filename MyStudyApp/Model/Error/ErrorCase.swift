//
//  ErrorCase.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/08.
//

import Foundation

enum statusCodeError: Int, Error {
    case renewalToken = 401
    case serverError = 500
    case clientError = 501
}

extension statusCodeError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .renewalToken:
            return "토큰 갱신"
        case .serverError:
            return "서버에러"
        case .clientError:
            return "클라이언트 에러"
        }
    }
}
