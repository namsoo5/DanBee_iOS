//
//  ViewController.swift
//  DanBee_iOS
//
//  Created by 남수김 on 14/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import NMapsMap
import MaterialCard
import RxSwift
import RxCocoa

class MainViewController: UIViewController, NMFMapViewDelegate, CLLocationManagerDelegate {
    
   
    
    @IBOutlet weak var borrowStateView: MaterialCard!
    @IBOutlet weak var naverMap: NMFNaverMapView!
    @IBOutlet weak var timeLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var locationOverlay: NMFLocationOverlay!
    
    let stateViewVisibleObservable: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.naverMap.delegate = self
        mapSet()
        loactionSet()
        sideMenuButtonInit()
        autoLogin()
        borrowViewSet()
        bind()
    }

    @IBAction func lendButtonClick(_ sender: Any) {
       
        KickBoardService.shared.getLendResult{ result in
            
            switch result {
            case 777:
                UserInfo.shared.state = false
                self.simpleAlert(title: "반납성공", msg: """
성공적으로 반납하였습니다.
단비를 이용해주셔서 감사합니다.
""")
            default:
                self.simpleAlert(title: "반납실패", msg:"반납하는 도중 알 수 없는 오류가 발생했습니다.")
                
            }
            
        }
        
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
    
    func borrowViewSet(){
        self.borrowStateView.backgroundColor = .danbeeColor1
        self.borrowStateView.layer.cornerRadius = 20
        self.borrowStateView.layer.borderWidth = 2
        self.borrowStateView.layer.borderColor = UIColor.lightGray.cgColor
        self.timeLabel.text = UserInfo.shared.time
    }
    
    func bind(){
        self.stateViewVisibleObservable
            .bind(to: self.borrowStateView.rx.isHidden)
            .disposed(by: disposeBag)
        
        self.stateViewVisibleObservable
            .onNext(UserInfo.shared.state)
    }
    
}

extension MainViewController {
    
    //위치 초기화
    func loactionSet(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest    //정확도
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
