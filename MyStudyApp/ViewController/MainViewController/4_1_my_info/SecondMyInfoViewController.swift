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
            
            //cardCell.nickNameView.tag = indexPath.row // ????????? ????????? ???
            let cardViewTabed = UITapGestureRecognizer(target: self, action: #selector(toggleBool))
            cardCell.nickNameView.addGestureRecognizer(cardViewTabed)
            
            if cardStatus { //?????????
                cardCell.expandImage.image = UIImage(named: "up_arrow")
                cardCell.titleView.isHidden = false
                cardCell.reviewView.isHidden = false
            } else { //??????
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
            if cardStatus { //?????????
                return 504
            } else { //??????
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
////        cell.userNicklabel.text = "?????????"
//
//        /*
//         cell.textLabel?.text = self.tableViewData[indexPath.section][indexPath.row]
//
//         */
//
//        if indexPath.row == 0 { // ?????? ??????
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondMyInfoDetailTableView.identifier, for: indexPath) as? SecondMyInfoDetailTableView else { return UITableViewCell() }
//
//            return cell
//        } else { //????????? ?????????
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
//            //?????? ?????????
//            tableViewData[indexPath.section].selected = !tableViewData[indexPath.section].selected
//
//            //?????? ?????????
//            tableView.reloadSections([indexPath.section], with: .none)
//        } else {
//            print("sectionData?????????")
//        }
//
//        print("????????? ??????, ????????? ??????.??????", [indexPath.section], [indexPath.row])
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
//        let titleData = ["???", "???", "???", "???", "???", "???"]
//        cell.userTitleButton.setTitle(titleData[indexPath.row], for: .normal)
//        cell.backgroundColor = .green
//
//        return cell
//    }
//
//
//}
