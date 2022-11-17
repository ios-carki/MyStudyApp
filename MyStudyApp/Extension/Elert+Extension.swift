//
//  Elert+Extension.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/11.
//

import UIKit

extension UIViewController {
    
    func customAlert(alertTitle: String?, alertMessage: String?, alertStyle: UIAlertController.Style, actions: UIAlertAction?...) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: alertStyle)
        let cancel = UIAlertAction(title: "돌아가기", style: .cancel)
        
        for action in actions {
            alert.addAction(action ?? cancel)
        }
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
    
    //임시 커스텀얼럿2
    func oneButtonAlert(alertTitle: String?, alertMessage: String?, alertStyle: UIAlertController.Style, actions: UIAlertAction?...) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: alertStyle)
        let cancel = UIAlertAction(title: "돌아가기", style: .cancel)
        
        for action in actions {
            alert.addAction(action ?? cancel)
        }
        
        self.present(alert, animated: true)
    }
}
