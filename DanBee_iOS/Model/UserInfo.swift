//
//  UserInfo.swift
//  DanBee_iOS
//
//  Created by 남수김 on 17/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import RxSwift

class UserInfo{
    private init() { }
    static let shared = UserInfo()
    
    var userid = String()
    var name: String?
    var phone: String?
    var gender: Int?
    var birth: String?
    var kickid: Int?
    let stateViewVisibleObservable: BehaviorSubject<Bool> = BehaviorSubject(value: true)
    let timeTextObservable: BehaviorSubject<String> = BehaviorSubject(value: "")
    
    
    func logout(){
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "pw")
        self.userid = ""
        self.name = ""
        self.phone = ""
        self.gender = -1
        self.birth = ""
        self.kickid = -1
        UserInfo.shared.stateViewVisibleObservable.onNext(true)
    }
}
