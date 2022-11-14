//
//  BirthViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/08.
//

import UIKit

import Toast

final class BirthViewController: UIViewController {
    
    let mainView = BirthView()
    
    let datePicker = UIDatePicker()
    
    let dateFormatter: DateFormatter = {
        let format = DateFormatter()
        format.dateStyle = .medium
        format.timeStyle = .none
        
        return format
    }()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.yearButton.becomeFirstResponder()
        nextButtonSetting()
        datePickerSetting()
        popupDatePicker()
    }
    
    func nextButtonSetting() {
        mainView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    @objc func nextButtonClicked() {
        if UserDefaults.standard.bool(forKey: "userBithConfirmed") {
            let vc = EmailViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            view.makeToast("새싹스터디는 만 17세 이상만 사용할 수 있습니다.", position: .top)
        }
    }
    
    func datePickerSetting() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
    }
    
    func popupDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target : nil, action: #selector(donePressed))
        
        toolbar.setItems([doneButton], animated: true)
        
        mainView.yearButton.inputAccessoryView = toolbar
        mainView.yearButton.inputView = datePicker
        
        mainView.monthButton.inputAccessoryView = toolbar
        mainView.monthButton.inputView = datePicker
        
        mainView.dayButton.inputAccessoryView = toolbar
        mainView.dayButton.inputView = datePicker
        
        
    }
    
    @objc func donePressed(){
        let pickedDate = datePicker.date
        
        dateFormatter.dateFormat = "yyyy"
        guard let userPickedYear = Int(dateFormatter.string(from: pickedDate)) else { return }
        
        dateFormatter.dateFormat = "Md"
        guard let userPickedMonthDay = Int(dateFormatter.string(from: pickedDate)) else { return }
        
        if calculateUserAge(userPickedYear: userPickedYear, userPickedMonthDay: userPickedMonthDay) {
            
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            
            //UPDATE: 유저데이터 빠른 확인을위해 유저디폴트 사용 -> 나중에 삭제 후 구조체 직접 대입으로 바꾸기
//            UserDefaults.standard.set(dateFormatter.string(from: pickedDate), forKey: "birth")
//            print("저장된 생일 데이터: ", UserDefaults.standard.string(forKey: "birth"))
            
            //생년월일 데이트
            let user = User.shared
            user.birth = dateFormatter.string(from: pickedDate)
            
            dateFormatter.dateFormat = "yyyy"
            mainView.yearButton.text = dateFormatter.string(from: pickedDate)
            
            dateFormatter.dateFormat = "M"
            mainView.monthButton.text = dateFormatter.string(from: pickedDate)
            
            dateFormatter.dateFormat = "d"
            mainView.dayButton.text = dateFormatter.string(from: pickedDate)
            
            mainView.nextButton.backgroundColor = .colorGreen
            
            UserDefaults.standard.set(true, forKey: "userBithConfirmed")
            self.view.endEditing(true)
        } else {
            view.makeToast("새싹스터디는 만 17세 이상만 사용할 수 있습니다.", position: .top)
            self.view.endEditing(false)
        }
        
        
    }
    
    func calculateUserAge(userPickedYear: Int, userPickedMonthDay: Int) -> Bool {
        let nowDate = Date()
        dateFormatter.dateFormat = "yyyy"
        
        guard let nowYear = Int(dateFormatter.string(from: nowDate)) else { return false }
        var countUserAge = nowYear - userPickedYear
        
        dateFormatter.dateFormat = "Md"
        guard let nowMonthDay = Int(dateFormatter.string(from: nowDate)) else { return false }
        var isBirthDone = nowMonthDay - userPickedMonthDay
        
        if countUserAge >= 17 && isBirthDone >= 0 {
            return true
        } else if countUserAge > 17 {
            return true
        } else {
            return false
        }
    }
}
