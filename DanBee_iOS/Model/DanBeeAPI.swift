//
//  DanBeeAPI.swift
//  DanBee_iOS
//
//  Created by 남수김 on 16/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation

struct DanBeeAPI {
    static let homeURL = "http://3.17.25.223/api/"
    static let signUpURL = homeURL + "user/signup"
    static let loginURL = homeURL + "user/login"
    static let checkIdURL = homeURL + "user/find/"
}
