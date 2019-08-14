//
//  ViewController.swift
//  DanBee_iOS
//
//  Created by 남수김 on 14/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import NMapsMap

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        mapSet()
    }


}

extension ViewController {
    
    func mapSet() {
        let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)
    }
    
}

