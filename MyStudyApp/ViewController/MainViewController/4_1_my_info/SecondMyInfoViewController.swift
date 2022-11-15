//
//  SecondMyInfoViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/14.
//

import UIKit

//struct cellData {
//    var selected = Bool()
//    var expandCell = [UITableViewCell]()
//}

final class SecondMyInfoViewController: UIViewController {
    
    let mainView = SecondMyInfoView()
    //    let collectionViewLocation = SecondMyInfoExpandTableView()
    //
    //    var tableViewData = [cellData]()
    //    var hiddenSection = Set<Int>()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cardCell = tableView.dequeueReusableCell(withIdentifier: CardViewTableCell.identifier, for: indexPath) as? CardViewTableCell else { return UITableViewCell() }
            cardCell.selectionStyle = .none
            
            return cardCell
        } else {
            guard let settingCell = tableView.dequeueReusableCell(withIdentifier: UserSettingTableCell.identifier, for: indexPath) as? UserSettingTableCell else { return UITableViewCell() }
            
            settingCell.selectionStyle = .none
            
            if indexPath.row == 1 {
                settingCell.genderView.isHidden = false
            } else if indexPath.row == 2 {
                settingCell.mainStudyView.isHidden = false
            } else if indexPath.row == 3 {
                settingCell.searchPhoneNumView.isHidden = false
            } else if indexPath.row == 4 {
                settingCell.userAgeGroupView.isHidden = false
            } else if indexPath.row == 5 {
                settingCell.resignView.isHidden = false
            }
            return settingCell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 290
        } else if indexPath.row == 4 {
            return 80
        }
        
        return 64
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
