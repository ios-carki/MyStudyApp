//
//  String+Extension.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/09.
//

import UIKit

extension String {
    
    func isPhone(candidate: String) -> Bool {

        //let regex = "^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$"
        let phoneRegEx = "[0-9]{11}"
        

        return NSPredicate(format: "SELF MATCHES %@", phoneRegEx).evaluate(with: candidate)

    }
    
    func isValidPhone(phone: String?) -> Bool {
        guard phone != nil else { return false }

        let phoneRegEx = "[0-9]{11}"
        let pred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return pred.evaluate(with: phone)
    }

}
