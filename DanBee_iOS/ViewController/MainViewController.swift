//
//  ViewController.swift
//  DanBee_iOS
//
//  Created by 남수김 on 14/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import NMapsMap

class MainViewController: UIViewController, NMFMapViewDelegate, CLLocationManagerDelegate {
    
   
    @IBOutlet weak var naverMap: NMFNaverMapView!
    
    let locationManager = CLLocationManager()
    var locationOverlay: NMFLocationOverlay!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.naverMap.delegate = self
        mapSet()
        loactionSet()
        sideMenuButtonInit()
        autoLogin()
    
    }

}

extension MainViewController {
    
    func sideMenuButtonInit(){
        let menuButton = UIBarButtonItem.init(title: "Menu", style: .plain, target: self, action: #selector(openSideMenu))
        self.navigationItem.leftBarButtonItem = menuButton
    }
    
    @objc func openSideMenu(){
        guard let sideMenuVC = self.storyboard?.instantiateViewController(withIdentifier: "sideMenu") else { return }
        self.present(sideMenuVC, animated: true, completion: nil)
    }
    
    func autoLogin() {
        // Review: [Refactoring] UserDefaults 의 Key를 String literal 로 접근하는 것보단 enum 으로 접근하는건 어떨가요?
        // https://github.com/ramprasadios/ShooppingCart/blob/4fab73251b43aca6ad0a377b3ae0d79547ed236e/Alzahrani/Alzahrani/Utilities/DefaultsManager.swift
        if let userid = UserDefaults.standard.string(forKey: "id") {
            if let pw = UserDefaults.standard.string(forKey: "pw") {
                LoginService.shared.getLoginResult(userid: userid, pw: pw){ b in
                    if b {
                        print("auto login")
                    }
                }
            }
        }
    }
    
}

extension MainViewController {
    
    //위치 초기화
    func loactionSet(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest    //정확도
        // Review: [사용성] Localtion 접근 권한 상태를 확인하고 요청하는 것이 좋지 않을까요?
        /*switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            break
        }*/
        locationManager.requestWhenInUseAuthorization()    //권한요청
        locationManager.distanceFilter = 20    //해당거리이동시 업데이트
        locationManager.startUpdatingLocation()    //위치정보 업데이트시작
        let lat = self.locationManager.location?.coordinate.latitude
        let lng = self.locationManager.location?.coordinate.longitude
        print("lat:\(String(describing: lat)), lng:\(String(describing: lng))")
        
        let latlng = NMGLatLng(lat: lat ?? 37.487241, lng: lng ?? 126.825390)
        let cameraUpdate = NMFCameraUpdate(scrollTo: latlng)
        naverMap.mapView.moveCamera(cameraUpdate)
    }
    
    //위치 변경시
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locate = locations[locations.count - 1]
        let lat = locate.coordinate.latitude
        let lng = locate.coordinate.longitude
        print("update! lat:\(lat), lng:\(lng)")
        
        locationOverlay.location = NMGLatLng(lat: lat, lng: lng)
    }
    
    func mapSet() {
        naverMap.positionMode = .normal
        self.locationOverlay = self.naverMap.mapView.locationOverlay
        
        
        
//        let marker = NMFMarker()
//        marker.position = NMGLatLng(lat: 37.5670135, lng: 126.9783740)
//        marker.mapView = mapView
//        marker.iconImage = NMFOverlayImage(name: "marker_icon")
//        marker.iconImage = NMF_MARKER_IMAGE_BLACK
//        marker.iconTintColor = UIColor.red
//        marker.iconPerspectiveEnabled = true
    }
}
