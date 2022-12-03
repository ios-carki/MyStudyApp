//
//  MatchingStudyViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/16.
//

import UIKit
import CoreLocation

import Toast

final class MatchingStudyViewController: UIViewController {
    
    private let mainView = MatchingStudyView()
    
    let modelView = APIService()
    
    var arroundUserData: [SearchUserDataFromQueueDB] = []
    var studyList: [String] = []
    
    var searchBarIsFiltering: Bool = false
    var tempArr: [String] = []
    var filterdText: [String] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviSetting()
        searchSesacButtonSetting()
        collectionViewSetting()
        nextVCnaviSetting()
        
        searchAPI(lat: UserDefaults.standard.string(forKey: "currentLocationLat")!, long: UserDefaults.standard.string(forKey: "currentLocationLong")!)
        
        print("유저 데이터 카운팅: 🦍🦍🦍🦍🦍🦍🦍🦍🦍", arroundUserData.count)
        print("받은 좌표: 🤢🤢🤢🤢🤢🤢🤢🤢", UserDefaults.standard.string(forKey: "currentLocationLat")!, UserDefaults.standard.string(forKey: "currentLocationLong")!)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("뷰 사라짐 유저 데이터!: ",arroundUserData)
    }
    
    func naviSetting() {
        //서치바 크기 구해서 백버튼 모든 기기가 동일한 사이즈로 보이도록 구상하기
        mainView.searchBar.placeholder = "띄워쓰기로 복수 입력이 가능해요."
        mainView.searchBar.delegate = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainView.searchBar)
        
        let backBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow"), style: .done, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    func nextVCnaviSetting() {
        let backButton: UIBarButtonItem = {
            let button = UIBarButtonItem()
            button.image = UIImage(named: "arrow")
            
            return button
        }()
        
        
        self.navigationItem.backBarButtonItem = backButton
    }
    
    func collectionViewSetting() {
        //헤더
        mainView.studyCollectionView.register(StudyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StudyHeaderView.identifier)
        
        //셀
        mainView.studyCollectionView.register(AroundStudyCollectionViewCell.self, forCellWithReuseIdentifier: AroundStudyCollectionViewCell.identifier)
        mainView.studyCollectionView.register(StudyCollectionViewCell.self, forCellWithReuseIdentifier: StudyCollectionViewCell.identifier)
        
        mainView.studyCollectionView.delegate = self
        mainView.studyCollectionView.dataSource = self
    }
    
    
    func searchSesacButtonSetting() {
        mainView.searchSesacButton.addTarget(self, action: #selector(searchSesacButtonClicked), for: .touchUpInside)
    }
    
    @objc func searchSesacButtonClicked() {
        if filterdText.count == 0 {
            myQueueAPI(lat: UserDefaults.standard.string(forKey: "currentLocationLat")!, long: UserDefaults.standard.string(forKey: "currentLocationLong")!, studyList: "anything")
        } else {
            myQueueAPI(lat: UserDefaults.standard.string(forKey: "currentLocationLat")!, long: UserDefaults.standard.string(forKey: "currentLocationLong")!, studyList: arrayToString(list: filterdText))
        }
        
    }
    
    func arrayToString(list: [String]) -> String {
        let itemStr = list.joined(separator: "\", \"")
        return "[" + "\"" + itemStr + "\"" + "]"
    }

    
    func myQueueAPI(lat: String, long: String, studyList: String) -> Bool {
        var queueValidation = false
        
        modelView.userQueue(latitude: lat, longitude: long, studyList: studyList) { statusCode in
            print("유저큐 메서드 상태코드: ", statusCode)
            switch statusCode {
            case 200:
                let vc = TabManViewController()
                
                //매칭 대기중으로 변경
                UserDefaults.standard.set(0, forKey: "matchingStatus")
                
                self.navigationController?.pushViewController(vc, animated: true)
                return
            case 201:
                self.view.makeToast("신고가 누적되어 이용하실 수 없습니다.", position: .top)
                
                return
            case 203:
                self.view.makeToast("스터디 취소 패널티로, 1분동안 이용하실 수 없습니다.", position: .top)
                
                return
            case 204:
                self.view.makeToast("스터디 취소 패널티로, 2분동안 이용하실 수 없습니다.", position: .top)
                
                return
            case 205:
                self.view.makeToast("스터디 취소 패널티로, 3분동안 이용하실 수 없습니다.", position: .top)
                
                return
            case 401:
                return
            case 406:
                return
            case 500:
                return
            case 501:
                return
            default:
                return
            }
        }
        
        return queueValidation
    }
    
    //Revise: static으로 관리하기
    func searchAPI(lat: String, long: String) {
        modelView.searchSeSAC(latitude: lat, longitude: long) { (statusCode, data) in
            let apiData = data.fromQueueDB
            
            switch statusCode {
            case 200:
                print("새싹 검색 성공🤢🤢🤢🤢🤢🤢🤢🤢")
                //서버 데이터 받아오기
                self.arroundUserData = apiData
                for i in 0..<apiData.count {
                    self.studyList.append(contentsOf: apiData[i].studylist)
                    print("넣는 스터디 요소: \(i): ", apiData[i].studylist)
                    print("스터디 리스트 출력 \(i): ", self.studyList)
                    self.mainView.studyCollectionView.reloadData()
                }
                print("데이터 목록: 🦍🦍🦍🦍🦍🦍🦍🦍", apiData)
            case 401:
                print("FireBase Token Error 토큰 갱신 ㄱ ㄱ")
                self.modelView.getIdToken()
            case 406:
                print("미가입 회원")
                
            case 500:
                print("서버 에러 - FCMtoken 확인")
                
            case 501:
                print("클라이언트 에러 - 얼럿 띄워야 되나?")
            default:
                print("기본")
            }
        }
    }
    
}

extension MatchingStudyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return studyList.count
        } else {
            return filterdText.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AroundStudyCollectionViewCell.identifier, for: indexPath) as? AroundStudyCollectionViewCell else { return UICollectionViewCell() }
            
            cell.studyText.text = studyList[indexPath.item]
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StudyCollectionViewCell.identifier, for: indexPath) as? StudyCollectionViewCell else { return UICollectionViewCell() }
            
            cell.studyText.text = filterdText[indexPath.item]
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}


extension MatchingStudyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section == 0 {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: StudyHeaderView.identifier, for: indexPath) as! StudyHeaderView
                
                header.headerLabel.text = "지금 주변에는"
                
                header.backgroundColor = .white
                
                return header
            } else {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: StudyHeaderView.identifier, for: indexPath) as! StudyHeaderView
                
                header.headerLabel.text = "내가 하고 싶은"
                
                header.backgroundColor = .white
                
                return header
            }
            
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 18)
    }
}

extension MatchingStudyViewController: UISearchBarDelegate {
    
    //MARK: 서치바 검색 시작
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBarIsFiltering = true
        //Revise: 취소버튼 생기면 어떻게 될까
//        searchBar.showsCancelButton = true
        mainView.studyCollectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text?.lowercased() else { return }
        //여기서부터
    }

    //MARK: 검색 버튼 눌렀을 때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()

        guard let text = searchBar.text?.lowercased() else { return }
        let filterTxt = text.components(separatedBy: ["~", "!", "@", ",", " "])
        tempArr.append(contentsOf: filterTxt.filter { $0 != ""})
        filterdText = tempArr.removeDuplicates()
        mainView.studyCollectionView.reloadData()
        //추가와 동시에 중복 제거
    }

    //MARK: 서치바에서 취소버튼 눌렀을때
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.searchBarIsFiltering = false
        mainView.studyCollectionView.reloadData()
    }

    //MARK: 서치바 검색 끝
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        mainView.studyCollectionView.reloadData()
    }

    //MARK: 키보드 내리기
    func dismissKeyboard() {
        mainView.searchBar.resignFirstResponder()
    }
}

//MARK: 배열 중복 제거
extension Array where Element: Hashable {
    func removeDuplicates() -> [Element] {
        var set = [Element: Bool]()
        return filter { set.updateValue(true, forKey: $0) == nil }
    }
}
