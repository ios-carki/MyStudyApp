//
//  GenderViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/09.
//

import UIKit

final class GenderViewController: UIViewController {
    
    let mainView = GenderView()
    
    //manView, womanView에 텝 제스쳐 줄것
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
