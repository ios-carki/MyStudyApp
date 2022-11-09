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

}
