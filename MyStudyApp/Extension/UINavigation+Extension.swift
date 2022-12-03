//
//  UINavigation+Extension.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/03.
//

import UIKit

extension UINavigationController {
    func popViewController(animated: Bool, completion:@escaping (()->())) -> UIViewController? {
            CATransaction.setCompletionBlock(completion)
            CATransaction.begin()
            let poppedViewController = self.popViewController(animated: animated)
            CATransaction.commit()
            return poppedViewController
        }
        
        func pushViewController(_ viewController: UIViewController, animated: Bool, completion:@escaping (()->())) {
            CATransaction.setCompletionBlock(completion)
            CATransaction.begin()
            self.pushViewController(viewController, animated: animated)
            CATransaction.commit()
        }
}
