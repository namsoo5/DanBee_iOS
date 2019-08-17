//
//  UIButton+Extension.swift
//  DanBee_iOS
//
//  Created by 남수김 on 16/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    override open func awakeFromNib() {
        self.layer.cornerRadius = 8
        
        //일반 텍스트버튼은 적용안함
        if self.tag != 10 {
            self.backgroundColor = UIColor.danbeeColor1
        }
    }
}

