//
//  UserInfo.swift
//  DanBee_iOS
//
//  Created by 남수김 on 17/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import RxSwift

let admin = ["jh"]
class UserInfo{
    private init() { }
    static let shared = UserInfo()
    
    var userid = String() {
        willSet{
            for name in admin{
                if name == newValue{
                    isAdmin = true
                    break
                }
            }
        }
    }
    var name: String?
    var phone: String?
    var gender: Int?
    var birth: String?
    var kickid: Int?
    var isAdmin = false
    
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
        self.isAdmin = false
        UserInfo.shared.stateViewVisibleObservable.onNext(true)
    }
}
