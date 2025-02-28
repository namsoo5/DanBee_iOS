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
    
    var danbeeKickBoard = [KickBoard]()
    
    @IBOutlet weak var borrowStateView: MaterialCard!
    @IBOutlet weak var naverMap: NMFNaverMapView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lendButton: UIButton!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    let locationManager = CLLocationManager()
    var locationOverlay: NMFLocationOverlay!
    
    
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
        refreshButtonSet()
    }

    @IBAction func lendButtonClick(_ sender: Any) {
        
        self.choiceAlert(title: "확인", msg: "정말 반납하시겠습니까?", okHandler: {
            _ in
            KickBoardService.shared.getLendResult{ result in
                
                switch result {
                case 777:
                    UserInfo.shared.stateViewVisibleObservable.onNext(true)
                    UserInfo.shared.kickid = -1
                    self.simpleAlert(title: "반납성공", msg: """
성공적으로 반납하였습니다.
단비를 이용해주셔서 감사합니다.
""")
                default:
                    UserInfo.shared.stateViewVisibleObservable.onNext(false)
                    self.simpleAlert(title: "반납실패", msg:"반납하는 도중 알 수 없는 오류가 발생했습니다.")
                    
                }
                
            }
        })
        
        
    }
}

extension MainViewController {
    
    func sideMenuButtonInit(){
        let menuButton = UIBarButtonItem.init(title: "Menu", style: .plain, target: self, action: #selector(openSideMenu))
        self.navigationItem.leftBarButtonItem = menuButton
    }
    
    @objc func openSideMenu(){
        guard let sideMenuVC = self.storyboard?.instantiateViewController(withIdentifier: "sideMenu") else { return }
        sideMenuVC.modalPresentationStyle = .fullScreen
        self.present(sideMenuVC, animated: true, completion: nil)
    }
    
    func autoLogin() {
        if let userid = UserDefaults.standard.string(forKey: "id") {
            if let pw = UserDefaults.standard.string(forKey: "pw") {
                LoginService.shared.getLoginResult(userid: userid, pw: pw){ b in
                    if b {
//                        print("auto login")
                    }
                }
            }
        }
    }
    
    func borrowViewSet(){
        self.borrowStateView.backgroundColor = .danbeeColor1
        self.borrowStateView.layer.cornerRadius = 20
        self.borrowStateView.layer.borderWidth = 2
        self.borrowStateView.layer.borderColor = UIColor.danbeeColor2.cgColor
        
        self.lendButton.layer.cornerRadius = 26
        self.lendButton.backgroundColor = UIColor.danbeeColor2
    }
    
    func bind(){
        UserInfo.shared.stateViewVisibleObservable
            .bind(to: self.borrowStateView.rx.isHidden)
            .disposed(by: disposeBag)
        
        UserInfo.shared.timeTextObservable
            .bind(to: self.timeLabel.rx.text)
            .disposed(by: disposeBag)
    }
    //MARK: - 킥보드위치
    //새로고침버튼생성
    func refreshButtonSet(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonClick))
    }
    
    @objc func refreshButtonClick(){
        self.indicator.startAnimating()
        kickGPSRequest()
    }
    
    func kickGPSRequest(){
        KickBoardService.shared.getGPSResult(){
            (b, kicks) in
            if b {
                self.danbeeKickBoard = kicks
                self.markerSet()
                
            }
            self.indicator.stopAnimating()
        }
    }
    
}

//MARK: - 네이버지도
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
//        print("lat:\(String(describing: lat)), lng:\(String(describing: lng))")
        
        let latlng = NMGLatLng(lat: lat ?? 37.487241, lng: lng ?? 126.825390)
        let cameraUpdate = NMFCameraUpdate(scrollTo: latlng)
        naverMap.mapView.moveCamera(cameraUpdate)
    }
    
    //위치 변경시
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locate = locations[locations.count - 1]
        let lat = locate.coordinate.latitude
        let lng = locate.coordinate.longitude
//        print("update! lat:\(lat), lng:\(lng)")
        
        locationOverlay.location = NMGLatLng(lat: lat, lng: lng)
    }
    
    func mapSet() {
        naverMap.positionMode = .normal
        self.locationOverlay = self.naverMap.mapView.locationOverlay
        
        self.kickGPSRequest()
        
//        let marker = NMFMarker()
//        marker.position = NMGLatLng(lat: 37.5670135, lng: 126.9783740)
//        marker.mapView = mapView
//        marker.iconImage = NMFOverlayImage(name: "marker_icon")
//        marker.iconImage = NMF_MARKER_IMAGE_BLACK
//        marker.iconTintColor = UIColor.red
//        marker.iconPerspectiveEnabled = true
    }
    
    func markerSet(){
        
        for danbee in danbeeKickBoard{
            let marker = NMFMarker()
            marker.width = 40
            marker.height = 40
            marker.position = NMGLatLng(lat: danbee.lat, lng: danbee.lng)
            marker.mapView = naverMap.mapView
            marker.iconImage = NMFOverlayImage(name: "danbeeMarker")
            marker.iconPerspectiveEnabled = true
        }
    }
}
