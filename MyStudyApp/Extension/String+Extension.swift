//
//  String+Extension.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/09.
//

import UIKit

extension String {
    
    func isValidPhone(phone: String?) -> Bool {
        guard phone != nil else { return false }

        let phoneRegEx = "[0-9]{11}"
        let pred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return pred.evaluate(with: phone)
    }
    
    func pretty() -> String {
        let _str = self.replacingOccurrences(of: "-", with: "") // 하이픈 모두 빼준다
        let arr = Array(_str)
        
        if arr.count > 3 {
            let prefix = String(format: "%@%@%@", String(arr[0]), String(arr[1]), String(arr[2]))
            
            if prefix == "010" {
                if let regex = try? NSRegularExpression(pattern: "([0-9]{3})([0-9]{4}))", options: .caseInsensitive) {
                    let modString = regex.stringByReplacingMatches(in: _str, options: [],
                                                                   range: NSRange(_str.startIndex..., in: _str),
                                                                   withTemplate: "$1-$2-$3")
                    return modString
                }
                
            }else if prefix == "011" {
                if let regex = try? NSRegularExpression(pattern: "([0-9]{3})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
                    let modString = regex.stringByReplacingMatches(in: _str, options: [],
                                                                   range: NSRange(_str.startIndex..., in: _str),
                                                                   withTemplate: "$1-$2-$3")
                    return modString
                }
            }
        }
        return self
    }
}
