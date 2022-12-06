//
//  Date+Extension.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/06.
//

import Foundation

extension Date {

    public func formatted(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
        
        return formatter.string(from: self)
    }
}
