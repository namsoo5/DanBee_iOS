//
//  ViewController.swift
//  DanBee_iOS
//
//  Created by 남수김 on 14/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import NMapsMap
import VHBoomMenuButton

class ViewController: UIViewController {
    
    @IBOutlet weak var bmbMenu: BoomMenuButton!
    @IBOutlet weak var naverMap: NMFMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bombSet()
    }


}

extension ViewController {
    
    func bombSet() {
        bmbMenu.piecePlaceEnum = .dot_7_4
        bmbMenu.buttonEnum = .textInsideCircle
        bmbMenu.buttonPlaceEnum = .sc_7_4
        bmbMenu.draggable = true
        
        for _ in 0..<bmbMenu.piecePlaceEnum.pieceNumber() {
            let builder = TextInsideCircleButtonBuilder.init()
            builder.normalText = "Text Inside"
            bmbMenu.addBuilder(builder)
        }
    }
 
}
