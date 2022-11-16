//
//  FristLoginViewModel.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/16.
//

import Foundation

import RxSwift
import RxCocoa

final class FristLoginViewModel {
    
    //텍스트필드의 텍스트를 받는 객체
    //input
    let phoneNumText = BehaviorSubject(value: "")
    
//    let isPhoneNumValid: Observable<UIColor> = Observable.just(.colorGreen)
//
    //기본값을 갖고 시작할때 = behaviorSubject (초기값) <-> 없을땐 PublishSubject
    //output
    let isPhoneNumValid = BehaviorSubject(value: false)
    
    //let isPhoneNumValid = PublishSubject<Bool>()
    
    init() {
        _ = phoneNumText.distinctUntilChanged()
            .map(checkPhoneNumValid)
            .bind(to: isPhoneNumValid)
    }
    
    private func checkPhoneNumValid(_ phoneNumber: String) -> Bool {
        return phoneNumber.count > 9
    }
    
    
}
