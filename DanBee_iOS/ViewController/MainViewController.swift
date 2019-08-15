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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loactionSet()
        sideMenuButtonInit()
        
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
        
    }
    
    func mapSet() {
        naverMap.positionMode = .normal
        
//        let marker = NMFMarker()
//        marker.position = NMGLatLng(lat: 37.5670135, lng: 126.9783740)
//        marker.mapView = mapView
//        marker.iconImage = NMFOverlayImage(name: "marker_icon")
//        marker.iconImage = NMF_MARKER_IMAGE_BLACK
//        marker.iconTintColor = UIColor.red
//        marker.iconPerspectiveEnabled = true
    }

 
}

