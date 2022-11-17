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
    
    //about location
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        floatingButtonSetting()
        mapViewSetting()
        userNowLocationButtonSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func floatingButtonSetting() {
        mainView.floationButton.addTarget(self, action: #selector(floatingSearchClicked), for: .touchUpInside)
    }
    
    @objc func floatingSearchClicked() {
        let vc = MatchingStudyViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func mapViewSetting() {
        mainView.mainMapView.showsUserLocation = true
        mainView.mainMapView.setUserTrackingMode(.follow, animated: true)
        
        self.currentLocation = locationManager.location
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func userNowLocationButtonSetting() {
        mainView.nowLocationButton.addTarget(self, action: #selector(userNowLocationButtonClicked), for: .touchUpInside)
    }
    
    @objc func userNowLocationButtonClicked() {
        mainView.mainMapView.showsUserLocation = true
        mainView.mainMapView.setUserTrackingMode(.follow, animated: true)
    }
    
    func moveLocation(latitudeValue: CLLocationDegrees, longtudeValue: CLLocationDegrees, delta span: Double) {
        
        
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longtudeValue)
        let pSpanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: pSpanValue)
        mainView.mainMapView.setRegion(pRegion, animated: true)
    }
    
    //위치 검색 & 찾기 할때
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
    
}

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
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let location = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(location, animated: true)
        
    }
    
    //이거 위치
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager = manager
        if locationManager.authorizationStatus == .authorizedWhenInUse { // CLLocationManager.authorizationStatus() -> iOS 14부터 디플
            currentLocation = locationManager.location
        }
        
        if let location = locations.first {
            print("위도: \(location.coordinate.latitude)")
            print("경도: \(location.coordinate.longitude)")
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
    
    
}
