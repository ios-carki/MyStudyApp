//
//  MainMapViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/16.
//

import UIKit
import MapKit

import CoreLocation

final class MainMapViewController: UIViewController {
    
    private let mainView = MainMapView()
    
    let modelView = APIService()
    
    //꺼내쓸 searchUserData
    var receivedUserData: [SearchUserDataFromQueueDB] = []
    
    //유저 매칭 상태 확인
    var userState: Int?
    var matchedUserID: String?
    
    //about location
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var runTimeInterval: TimeInterval?
    
    let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviSetting()
        floatingButtonSetting()
        mapViewSetting()
        userNowLocationButtonSetting()
        genderButtonSetting()
        
        let location = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
        mainView.mainMapView.setRegion(location, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userQueueState()
        floatingButtonImage()
        //navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.isNavigationBarHidden = false
    }
    
    func naviSetting() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func floatingButtonSetting() {
        mainView.floationButton.addTarget(self, action: #selector(floatingSearchClicked), for: .touchUpInside)
    }
    
    @objc func floatingSearchClicked() {
        print("유저 매칭상태 확인2222222: ", userState)
    
        if UserDefaults.standard.integer(forKey: "matchingStatus") == 0 {
            let vc = TabManViewController()
            
            navigationController?.pushViewController(vc, animated: true)
        } else if UserDefaults.standard.integer(forKey: "matchingStatus") == 1 {
            
            
            
            let vc = ChattingViewController()
            
            
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = MatchingStudyViewController()
            
            var currentLat = String(format: "%.4f", currentLocation.coordinate.latitude)
            var currentLong = String(format: "%.4f", currentLocation.coordinate.longitude)
            print("소수점 줄인 위치값: ", currentLat, currentLong)
            
            vc.arroundUserData = receivedUserData
            
            UserDefaults.standard.set(currentLat, forKey: "currentLocationLat")
            UserDefaults.standard.set(currentLong, forKey: "currentLocationLong")
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func floatingButtonImage() {
        
        if UserDefaults.standard.integer(forKey: "matchingStatus") == 0 { // 매칭 대기중
            mainView.floationButton.buttonImage = UIImage(named: "antenna")
        } else if UserDefaults.standard.integer(forKey: "matchingStatus") == 1 { // 매칭됨
            mainView.floationButton.buttonImage = UIImage(named: "message")
        } else {
            mainView.floationButton.buttonImage = UIImage(named: "search")
        }
    }
    
    //MARK: 현재 유저 매칭 상태
    func userQueueState() {
        
        modelView.myQueueState { data, statusCode in
            switch statusCode {
            case 200:
                print("200 데이터 확인: ", data)
                UserDefaults.standard.set(data?.matched, forKey: "matchingStatus")
                self.matchedUserID = data?.matchedUid
                return
            case 201:
                print("201 데이터 확인: ", data)
                UserDefaults.standard.set(2, forKey: "matchingStatus")
                
                return
            case 401:
                print("401출력")
                
                return
            case 406:
                print("미가입 회원")
                
                return
            case 500:
                print("sever error")
                
                return
            case 501:
                print("client error")
                
                return
            default:
                print("디폴트 출력됨")
                return
            }
        }
        print("현재 유저 매칭 상태 확인: ", userState)
        
    }
    
    func mapViewSetting() {
        mainView.mainMapView.delegate = self
        
        self.currentLocation = locationManager.location
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        //MARK: 커스텀 어노테이션 등록
        mainView.mainMapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: CustomAnnotationView.identifier)
    }
    
    //MARK: GPS버튼
    func userNowLocationButtonSetting() {
        //Revise: 위치권한 허용이 안되어있을때 얼럿 띄우기
        mainView.nowLocationButton.addTarget(self, action: #selector(userNowLocationButtonClicked), for: .touchUpInside)
    }
    
    @objc func userNowLocationButtonClicked() {
        mainView.mainMapView.showsUserLocation = true
        mainView.mainMapView.setUserTrackingMode(.follow, animated: true)
        
        let location = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
        mainView.mainMapView.setRegion(location, animated: true)
        
        self.searchAPI(lat: String(currentLocation.coordinate.latitude), long: String(currentLocation.coordinate.longitude))
    }
    
    //MARK: 성별 버튼 전체 - 남 - 여
    //성별버튼 클릭
    func genderButtonSetting() {
        mainView.allGenderButton.addTarget(self, action: #selector(allGenderButtonClicked), for: .touchUpInside)
        mainView.manGenderButton.addTarget(self, action: #selector(manGenderButtonClicked), for: .touchUpInside)
        mainView.womanGenderButton.addTarget(self, action: #selector(womanGenderButtonClicked), for: .touchUpInside)
    }
    
    @objc func allGenderButtonClicked() {
        
    }
    
    @objc func manGenderButtonClicked() {
        
    }
    
    @objc func womanGenderButtonClicked() {
        
    }
    
    //MARK: 이건뭐지
    func moveLocation(latitudeValue: CLLocationDegrees, longtudeValue: CLLocationDegrees, delta span: Double) {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longtudeValue)
        let pSpanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: pSpanValue)
        mainView.mainMapView.setRegion(pRegion, animated: true)
    }
    
    //MARK: 위치 검색 & 찾기 할때
    func findUserLocation(lat: CLLocationDegrees, long: CLLocationDegrees) {
        let findLocation = CLLocation(latitude: lat, longitude: long)
        let geoCoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        
        geoCoder.reverseGeocodeLocation(findLocation, preferredLocale: locale) { (placeMarks, error) in
            if let location: [CLPlacemark] = placeMarks {
                var userLocation: String = ""
                if let area: String = location.last?.locality {
                    userLocation += area
                }
                if let name: String = location.last?.name {
                    userLocation += ""
                    userLocation += name
                }
            }
        }
    }
    
    //MARK: 새싹 이미지 어노테이션
    func addCustomPin(sesacImage: Int, coordinate: CLLocationCoordinate2D) {
        let pin = CustomAnnotation(sesacImage: sesacImage, coordinate: coordinate)
        mainView.mainMapView.addAnnotation(pin)
    }
    
    //새싹 검색 API
    func searchAPI(lat: String, long: String) {
        modelView.searchSeSAC(latitude: lat, longitude: long) { (statusCode, data) in
            
            switch statusCode {
            case 200:
                print("새싹 검색 성공")
                //서버 데이터 받아오기
                
                self.receivedUserData = data.fromQueueDB
                for i in 0..<self.receivedUserData.count {
                    self.addCustomPin(sesacImage: self.receivedUserData[i].sesac, coordinate: CLLocationCoordinate2D(latitude: self.receivedUserData[i].lat, longitude: self.receivedUserData[i].long))
                }
                
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

//MARK: 지도관련
extension MainMapViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    //MARK: 나중에 이 코드 로그인 후로 옮기던가, 앱 시작할때로 옮기기
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                if self.locationManager.authorizationStatus == .denied || self.locationManager.authorizationStatus == .restricted {
                    self.customAlert(alertTitle: "오류 발생!", alertMessage: "위치 서비스 기능이 꺼져있어요.", alertStyle: .alert, actions: nil)
                } else {
                    //거리 정확도
                    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    self.locationManager.delegate = self
                    //위치권한 허용 Alert
                    self.locationManager.requestWhenInUseAuthorization()
                }
            } else {
                self.customAlert(alertTitle: "오류 발생!", alertMessage: "위치 서비스 제공 불가.", alertStyle: .alert, actions: nil)
            }
        }
        
    }
    
    //시작시 유저 위치 중심으로 확대
//    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
//        print("이거 호출 시점", #function)
//        let location = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
//        mapView.setRegion(location, animated: true)
//    }
    
    //이거 위치
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations 메서드 실행됨! ✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅")
        
        locationManager = manager
        if locationManager.authorizationStatus == .authorizedWhenInUse { // CLLocationManager.authorizationStatus() -> iOS 14부터 디플
            currentLocation = locationManager.location
        }
        
        if let location = locations.first {
            print("위도: \(location.coordinate.latitude)")
            print("경도: \(location.coordinate.longitude)")
            
            currentLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            
        }
    }
    
    //지도 움질일때 마다 호출됨
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        runTimeInterval = Date().timeIntervalSinceReferenceDate
        print("맵 센터: ", mapView.centerCoordinate)
        
        
        currentLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
//            print("검색API실행====Delay 0.5초====")
//            self.searchAPI(lat: String(searchLocation.latitude), long: String(searchLocation.longitude))
//        }
    }
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        print("❌❌❌❌❌어노테이션 삭제❌❌❌❌❌❌❌")
        mainView.mainMapView.removeAnnotations(mainView.mainMapView.annotations)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.searchAPI(lat: String(self.currentLocation.coordinate.latitude), long: String(self.currentLocation.coordinate.longitude))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치 받아오기 에러:", error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        case .restricted:
            print("위치권한 제한됨 ❌❌❌❌❌❌")
            break
        case .denied:
            print("위치권한 거부됨 ❌❌❌❌❌❌")
            break
        case .authorizedAlways:
            currentLocation = locationManager.location
        case .authorizedWhenInUse:
            currentLocation = locationManager.location
        case .authorized:
            currentLocation = locationManager.location
        default:
            break
        }
    }
    
    //좌표에 pin 찍기
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span :Double, title strTitle: String, subtitle strSubTitle:String) {
        mainView.mainMapView.removeAnnotations(mainView.mainMapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        annotation.title = strTitle
        annotation.subtitle = strSubTitle
        mainView.mainMapView.addAnnotation(annotation)
    }
    
        
    //MARK: 어노테션 관련
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? CustomAnnotation else { return nil }
        
        var annotationView = self.mainView.mainMapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.identifier)
            annotationView?.canShowCallout = false
            annotationView?.contentMode = .scaleAspectFit
        } else {
            annotationView?.annotation = annotation
        }
        
        let sesacImage: UIImage!
        let size = CGSize(width: 85, height: 85)
        UIGraphicsBeginImageContext(size)
        
        switch annotation.sesacImage {
        case 0:
            sesacImage = UIImage(named: "sesac_face_1")
        case 1:
            sesacImage = UIImage(named: "sesac_face_2")
        case 2:
            sesacImage = UIImage(named: "sesac_face_3")
        case 3:
            sesacImage = UIImage(named: "sesac_face_4")
        case 4:
            sesacImage = UIImage(named: "sesac_face_5")
        default:
            sesacImage = UIImage(named: "sesac_face_1")
        }
        
        sesacImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        annotationView?.image = resizedImage
        
        return annotationView
    }

    
}

