# 📱 About Project
이 프로젝트의 **가장 큰 특징으로는 서비스 기획자의 기획 요구사항과 디자이너의 UX/UI 디자인별 요구사항, 서버 개발자의 API 명세를 통한 서비스 레벨 단위의 프로젝트**이며, 핵심 기능으로는 **REST API 통신을 베이스로 MapKit과 GPS을 통해 주변 유저 탐색, 회원가입, 1:1 채팅, 인앱 결제** 등이 있습니다.

회원가입 뷰는 **FirebaseAuth를 통한 번호인증** 후 닉네임, 생년월일, 성별등을 기입하면 회원가입이 완료됩니다. 회원가입 뷰는 **View를 재사용하여 불필요한 뷰 파일을 만들지 않았으며** 유저가 입력하는 **텍스트에 대한 유효성 검증이 바로바로 이루어져야 되기 때문에 RxSwift를 사용한 MVVM 아키텍쳐로 구성**했습니다.

회원가입이 완료된 후 **CLLocation과 MapKit을 활용한 앱의 메인 지도뷰로 RootView가 전환**되며, 만약 **기존 유저가 로그인할 시 회원가입 로직은 건너 뛰며 RootView는 메인 지도뷰**가 됩니다.

이용자 상호간에 **매칭 요청 / 수락을 통해 매칭이 이루어지고** 매칭된 사용자끼리 **Web Socket를 통한 1:1 실시간 채팅**이 가능하며, 유저간 재 매칭을 고려해 **과거의 채팅 내용을 Realm DB를 통해 저장시켜 데이터 영속성을 유지**시켰으며 이를 통해 DB상 가장 마지막 날짜에 저장된 채팅 이력은 DB를 통해 받아오기 때문에 **불필요한 소켓 통신을 제외**시켜 앱 성능향상이 가능했습니다.

# 🔨 Tech
Architecture - MVC / MVVM

Framework - MapKit / UserNotifications / UIKit / CoreLocation / StoreKit

Library - Realm / Firebase / IQKeyboardManager / SnapKit / Toast / SocketIO / Hero / JJFloatingActionButton / Tabman / RxSwift / RxCocoa / Alamofire

Tool - Figma / Confluence / Swagger
# 📲 ScreenShot

<img width="710" alt="스크린샷 2022-12-17 오전 3 22 40" src="https://user-images.githubusercontent.com/44957712/208163975-9e9618e8-1e70-42bd-a2d7-ffa7584b418c.png">

<img width="469" alt="스크린샷 2022-12-17 오전 3 27 07" src="https://user-images.githubusercontent.com/44957712/208164674-f3a86026-b4ed-4b23-ac9f-b794d8027f44.png">

* * *
# 🔴 Trouble Shooting

### 1. 회원가입(SignUp) API Request
- Status Code 401(idToken 갱신 필요) Error Handling
  - 만료된 User idToken
      - 401 상태코드에 idToken 갱신 매서드 호출
      
```swift
// #1. idtoken 갱신 매서드
    func getIdToken() {
        
        guard let currentUser = Auth.auth().currentUser else { return }
        currentUser.getIDTokenForcingRefresh(true) { idToken, error in
          if let error = error {
            
            return;
          }
            self.loginFunc() //상태코드 401 분기처리
            
            UserDefaults.standard.set(idToken!, forKey: "idtoken")
            
            print("갱신된 id토큰으로 재 로그인 시도")
        }
    }
    
    func loginFunc() {
        modelView.login { (data, statusCode) in
            switch statusCode {
            
            .
            .
            .
            
            case 401:
                print("에러코드: ", statusCode)
                print("로그인 실패, idtoken 갱신필요")
                self.getIdToken()

            .
            .
            .
        }
    }
```
* * *
### 2. 휴대폰 번호 정규식
- 01으로 시작하고 총 11자리를 표현하는 정규식
```swift
    func isValidPhone(phone: String?) -> Bool {
        guard phone != nil else { return false }
        
        let phoneRegEx = "^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$"
        let pred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return pred.evaluate(with: phone)
    }
```
* * *
### 3. OnBoarding
- LaunchScreen에서 ViewController로 파일 변경
  - 기존 SceneDelegate에서 작성된 기존회원 / 신규회원 분기처리를 LoginAPI의 Status Code로 처리하기 위함
  - OnBoarding 후 기존회원 / 신규회원 분기처리 후 RootView 교체 매서드를 통해 화면전환
  
```swift
//RootView 교체 매서드
    func changeRootVC(ChangeVC: UIViewController) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        UIView.transition(with: (sceneDelegate?.window)!, duration: 0.6, options: [.transitionCrossDissolve], animations: nil, completion: nil)
        let nav = UINavigationController(rootViewController: ChangeVC)
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()

    }
```
* * *
### 4. ViewPagerLogic
<img width="200" alt="스크린샷 2022-12-17 오전 10 42 26" src="https://user-images.githubusercontent.com/44957712/208217351-1ad9d124-840e-46a1-8ed0-7ee87ee14329.png">

- 구현 View
  - 라이브러리를 사용하지 않고 바닐라 코딩으로 구현하기
    - 상단 카테고리(주변 새싹 / 받은 요청)를 버튼으로 구현
      - 선택한 카테고리에 맞는 버튼 하단에 초록색 UnderLine Bar(인디케이터) 이동 필수
        - 버튼으로 구성하다보니 자연스러운 애니메이션을 구현하지 못했음 (UIView Animation 학습 이전)
    - 상단 카테고리, 하단 Contents View를 UICollectionView로 구현
      - 좌, 우 스크롤이 가능한 카테고리 뷰를 구현할 수 있음
      - 선택한 카테고리에 맞게 하단 UnderLinde Bar도 자연스럽게 이동
      - 선택한 카테고리에 맞는 Contents View가 나오지 않는 문제
  - Tabman 라이브러리로 구현하기 <최종 채택 방식>
    - View 구성에 시간 단축
    - 직관적인 코드 구성가능
    
```swift
// 카테고리 바
    func pageBoySetting() {
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.backgroundView.style = .blur(style: .light)
        
        //메뉴버튼
        bar.buttons.customize { button in
            button.tintColor = .colorGray6
            button.selectedTintColor = .colorGreen
            button.font = .systemFont(ofSize: 14)
            button.selectedFont = .boldSystemFont(ofSize: 14)
        }
        
        //인디케이터
        bar.indicator.weight = .custom(value: 3)
        bar.indicator.tintColor = .colorGreen
        
        bar.layout.transitionStyle = .snap
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        
        
        addBar(bar, dataSource: self, at: .custom(view: mainView.tabBarView, layout: nil))
    }
    
    extension TabManViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "주변 새싹")
        case 1:
            return TMBarItem(title: "받은 요청")
        default:
            let title = "Page\(index)"
            return TMBarItem(title: title)
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return nil
    }
    
}

```
***
### 5. #selector함수 내 매개변수 전달
  - Button의 addTarget / UIView의 TapGestureRecognizer 매서드 작성과 같이 action함수에 매개변수가 있는 매서드 작성하는 법
  ```swift
  let viewTap = UITapGestureRecognizer(target: <#T##Any?#>, action: <#T##Selector?#>)
  let buttonTarget = UIButton.addTarget(<#T##self: UIControl##UIControl#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
  ```
  
```swift
//기존 코드

#cellForRowAt
.
.
.

let cardViewTapped = UITapGestureRecognizer(target: self, action: #selector(toggleBool(viewName: cell.NickNameView)))
cell.nickNameView.addGestureRecognizer(cardViewTapped)

.
.
.

#toggleBool()
@objc func toggleBool(viewName: UIView) {
    cardStatus[viewName.tag] = !cardStatus[viewName.tag]
    mainView.arroundSesacTableView.reloadRows(at: [IndexPath(row: viewName.tag, section: 0)], with: .none)
}

=> 제스처 인식 에러

////////////////////////////////////////해결////////////////////////////////////////
//CustomClass 구현

#CustomClass
class CustomTapGestureRecognizer: UITapGestureRecognizer {
    var targetView: UIView?
}

#cellForRowAt
.
.
.

let cardViewTapped = CustomTapGestureRecognizer(target: self, action: #selector(self.toggleBool(gesture: )))
cardViewTapped.targetView = cell.nickNameView
cell.nickNameView.addGestureRecognizer(cardViewTapped)

.
.
.
      
#toggleBool()
@objc func toggleBool(gesture: CustomTapGestureRecognizer) {
    cardStatus[gesture.targetView?.tag ?? 0] = !cardStatus[gesture.targetView?.tag ?? 0]
    mainView.arroundSesacTableView.reloadRows(at: [IndexPath(row: gesture.targetView?.tag ?? 0, section: 0)], with: .none)
}  
```
***
### 6. 주변 유저 검색이 잘 이루어지지 않은 이슈
- 어노테이션은 제대로 찍히나 새싹 검색뷰로 진입시 주변 새싹들의 studyList 값이 안보이는 현상 (검색 API의 request는 성공)
  - CLLocation을 통해서 받아오는 좌표값이 너무 자세함
    - CLLocation은 소수점 14자리까지 받아오기 때문에 좀 더 정확한?(깊은?) 좌표값을 받아오게 됨
  
  - 소수점 네자리까지만 받아오도록 로직을 변경하여 해당 이슈 해결
```swift
var currentLat = String(format: "%.4f", currentLocation.coordinate.latitude)
var currentLong = String(format: "%.4f", currentLocation.coordinate.longitude)
```
* * *
# 🤔 프로젝트 회고

협업을 통해 팀원간 이해관계 충돌에 대한 합의점 조정과 이슈 공유를 통해 Team Activity를 경험하게 됐고,

실제 서비스 레벨의 프로젝트를 통해 서비스 기획, 설계를 경험할 수 있는 기회의 프로젝트를 경험하게 됐습니다.

- **BaseView, BaseVC, BaseCell**를 활용하여 **확장성** 높은 코드구현.
- **MVVM + RxSwift**를 통한 반응형 프로그래밍.
- **RESTful** **API 통신**을 활용하여 **클라이언트 - 서버 개발**에 대한 숙련도 향상.
- **MapKit + GPS**를 통한 위치 기반 서비스 구현.
- **SocketIO**를 활용한 소켓통신기반 1:1 채팅 구현.
- **Realm**을 통한 과거 채팅 내역에 대한 데이터 영속성 유지.
- **FirebaseAuth**를 통해 **전화번호 인증 로직** 및 **idtoken 갱신** 구현.
- **FirebaseMessaging**을 통해 **Push Notification 구현** 및 **유저 매칭알림, 채팅 내용, 알림 개수 뱃지** 대응**.**
- **Sandbox 계정**을 통해 비소모성 **In-App Purchase** 테스트 구현.
