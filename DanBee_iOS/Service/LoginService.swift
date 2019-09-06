//
//  LoginService.swift
//  DanBee_iOS
//
//  Created by 남수김 on 16/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

struct LoginService {
    private init() { }
    static let shared = LoginService()
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    func getLoginResult(userid: String, pw: String, completion: @escaping (_ b: Bool) -> Void) {
        
        let body: Parameters = [
            "userid": userid,
            "pw": pw,
        ]
        
        Alamofire.request(DanBeeAPI.loginURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON {
            response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let result = json["result"].intValue
                if result == 777 {
                    let userInfo = json["data"].arrayValue[0]
                    UserInfo.shared.name = userInfo["name"].stringValue
                    UserInfo.shared.userid = userInfo["userid"].stringValue
                    UserInfo.shared.phone = userInfo["phone"].stringValue
                    UserInfo.shared.birth = userInfo["birth"].stringValue
                    UserInfo.shared.gender = userInfo["gender"].intValue
                    
                    self.getStateResult(userid: UserInfo.shared.userid)
                    
                    completion(true)
                }else{
                    completion(false)
                }
            default:
                return
            }
        }
    }
    
    func getStateResult(userid: String) {
        
        let url = DanBeeAPI.userStateURL + userid
        
        Alamofire.request(url).responseJSON {
            response in
            
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let result = json["result"].intValue
                
                if result == 777 {
                    let kickid = json["kickid"].intValue
                    let time = json["time"].stringValue
                    UserInfo.shared.kickid = kickid
                    UserInfo.shared.timeTextObservable.onNext(time)
                    if kickid != -1 {
                        UserInfo.shared.stateViewVisibleObservable.onNext(false)
                    }
                }else{
                    UserInfo.shared.kickid = -1
                }
                
            default:
                return
            }
        }
    }
}
