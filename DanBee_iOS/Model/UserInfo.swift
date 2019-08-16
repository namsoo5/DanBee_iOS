//
//  UserInfo.swift
//  DanBee_iOS
//
//  Created by 남수김 on 17/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation

class UserInfo{
    static let shared = UserInfo()
    
    var userid: String?
    var name: String?
    var phone: String?
    var gender: Int?
    var birth: String?
    var kickid: Int?
    var time: String?
}
