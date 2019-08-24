//
//  Notice.swift
//  DanBee_iOS
//
//  Created by 남수김 on 24/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation

struct Notice{
    let date: String
    let title: String
    let content: String
    var open = false
    
    mutating func dateFormat() -> String{
        guard let s = self.date.split(separator: " ").first else {return "??"}
        
        return String(s)
    }
}
