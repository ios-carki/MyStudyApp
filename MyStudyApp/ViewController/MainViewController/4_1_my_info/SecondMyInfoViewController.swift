//
//  SecondMyInfoViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/14.
//

import UIKit

import RxSwift
import RxGesture

//struct cellData {
//    var selected = Bool()
//    var expandCell = [UITableViewCell]()
//}

final class SecondMyInfoViewController: UIViewController {
    
    let mainView = SecondMyInfoView()
    
    let disposeBag = DisposeBag()
    
    var cardStatus = false
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(cardStatus)
        tableSetting()
        //        collectionSetting()
    }
    
    func tableSetting() {
        mainView.infoTableView.register(CardViewTableCell.self, forCellReuseIdentifier: CardViewTableCell.identifier)
        mainView.infoTableView.register(UserSettingTableCell.self, forCellReuseIdentifier: UserSettingTableCell.identifier)
        
        mainView.infoTableView.delegate = self
        mainView.infoTableView.dataSource = self
    }
    
}

extension SecondMyInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 5
        }
        
    }
    
    @objc func toggleBool() {
        cardStatus = !cardStatus
        mainView.infoTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        print(cardStatus)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cardCell = tableView.dequeueReusableCell(withIdentifier: CardViewTableCell.identifier, for: indexPath) as? CardViewTableCell else { return UITableViewCell() }
            cardCell.requestButtonView.isHidden = true
            cardCell.selectionStyle = .none
            cardCell.backgroundColor = .white
            
            //cardCell.nickNameView.tag = indexPath.row // 카드뷰 펼치는 뷰
            let cardViewTabed = UITapGestureRecognizer(target: self, action: #selector(toggleBool))
            cardCell.nickNameView.addGestureRecognizer(cardViewTabed)
            
            if cardStatus { //펼처짐
                cardCell.expandImage.image = UIImage(named: "up_arrow")
                cardCell.titleView.isHidden = false
                cardCell.reviewView.isHidden = false
            } else { //닫힘
                cardCell.expandImage.image = UIImage(named: "down_arrow")
                cardCell.titleView.isHidden = true
                cardCell.reviewView.isHidden = true
            }
            
            
            cardCell.nickNameLabel.text = UserDefaults.standard.string(forKey: "nick") ?? ""
            
            
            return cardCell
        } else {
            guard let settingCell = tableView.dequeueReusableCell(withIdentifier: UserSettingTableCell.identifier, for: indexPath) as? UserSettingTableCell else { return UITableViewCell() }
            
            settingCell.selectionStyle = .none
            settingCell.backgroundColor = .white
            
            if indexPath.row == 0 {
                settingCell.genderView.isHidden = false
            } else if indexPath.row == 1 {
                settingCell.mainStudyView.isHidden = false
            } else if indexPath.row == 2 {
                settingCell.searchPhoneNumView.isHidden = false
            } else if indexPath.row == 3 {
                settingCell.userAgeGroupView.isHidden = false
            } else if indexPath.row == 4 {
                settingCell.resignView.isHidden = false
                settingCell.resignButton.addTarget(self, action: #selector(resignButtonClicked), for: .touchUpInside)
            }
            return settingCell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if cardStatus { //펼쳐짐
                return 504
            } else { //접힘
                return 268//292
            }
            //return 292
        } else {
            if indexPath.row == 3 {
                return 80
            }
        }
        return 64
//        if indexPath.row == 0 {
//            return 290
//        } else if indexPath.row == 4 {
//            return 80
//        }
//
//        return 64
    }
    
    @objc func resignButtonClicked() {
        let vc = MyInfoWithdrawViewController()
        vc.modalPresentationStyle = .overCurrentContext
        
        self.present(vc, animated: false)
    }
    
    
}
    
//    func tableSetting() {
//        mainView.detailTableView.register(SecondMyInfoDetailTableView.self, forCellReuseIdentifier: SecondMyInfoDetailTableView.identifier)
//        mainView.detailTableView.register(SecondMyInfoExpandTableView.self, forCellReuseIdentifier: SecondMyInfoExpandTableView.identifier)
//
//
//        tableViewData = [cellData(selected: false, expandCell: [UITableViewCell()])]
//
//        mainView.detailTableView.delegate = self
//        mainView.detailTableView.dataSource = self
//    }
//
//    func collectionSetting() {
//        mainView.detailTableView.register(sesacTitleCollectionView.self, forCellReuseIdentifier: sesacTitleCollectionView.identifier)
//
//        collectionViewLocation.titleCollectionView.delegate = self
//        collectionViewLocation.titleCollectionView.dataSource = self
//    }
//}
//
//extension SecondMyInfoViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return self.tableViewData.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if tableViewData[section].selected {
//            return tableViewData[section].expandCell.count + 1
//        } else {
//            return 1
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondMyInfoDetailTableView.identifier, for: indexPath) as? SecondMyInfoDetailTableView else { return UITableViewCell() }
////
////        cell.userNicklabel.text = "김새싹"
//
//        /*
//         cell.textLabel?.text = self.tableViewData[indexPath.section][indexPath.row]
//
//         */
//
//        if indexPath.row == 0 { // 기본 섹션
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondMyInfoDetailTableView.identifier, for: indexPath) as? SecondMyInfoDetailTableView else { return UITableViewCell() }
//
//            return cell
//        } else { //펼쳐진 데이터
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondMyInfoExpandTableView.identifier, for: indexPath) as? SecondMyInfoExpandTableView else { return UITableViewCell() }
//
//            return cell
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        if indexPath.row == 0 {
//            //섹션 여닫기
//            tableViewData[indexPath.section].selected = !tableViewData[indexPath.section].selected
//
//            //색션 리로드
//            tableView.reloadSections([indexPath.section], with: .none)
//        } else {
//            print("sectionData선택함")
//        }
//
//        print("인덱스 섹션, 인덱스 패스.로우", [indexPath.section], [indexPath.row])
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0 {
//            return 50
//        } else {
//            return 300
//        }
//    }
    


//extension SecondMyInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return UICollectionViewFlowLayout.automaticSize
//    }
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 6
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sesacTitleCollectionView.identifier, for: indexPath) as? sesacTitleCollectionView else { return UICollectionViewCell() }
//        let titleData = ["가", "나", "다", "라", "마", "바"]
//        cell.userTitleButton.setTitle(titleData[indexPath.row], for: .normal)
//        cell.backgroundColor = .green
//
//        return cell
//    }
//
//
//}
