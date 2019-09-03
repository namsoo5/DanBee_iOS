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
    
    // Review: [Refactoring] UserDefaults로 부터 값을 가져오는 것이 좋지 않을까요?
    // class 는 Call By Reference 이기 때문에 thread safe 하지 않습니다.
    var userid = String()
    var name: String?
    var phone: String?
    var gender: Int?
    var birth: String?
    var kickid: Int?
    var time: String?
    
    func logout(){
        // Review: [Refactoring] UserDefaults 내에 값을 Clear 해야 한다면...
        /*
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key)
        }
 */
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "pw")
        
        self.userid = ""
        self.name = ""
        self.phone = ""
        self.gender = -1
        self.birth = ""
        self.kickid = -1
        self.time = ""
    }
}
