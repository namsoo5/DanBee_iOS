//
//  MaterialCard+Extension.swift
//  DanBee_iOS
//
//  Created by 남수김 on 08/09/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import MaterialCard

extension MaterialCard {
    public override func awakeFromNib() {
        self.cornerRadius = 8
        self.shadowOffsetHeight = 2
        self.shadowOffsetWidth = 1
        self.shadowOpacity = 0.5
    
    }
}
