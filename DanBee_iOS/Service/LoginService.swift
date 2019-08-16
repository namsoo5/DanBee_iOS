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
                print(result)
                if result == 777 {
                    let userInfo = json["data"].arrayValue[0]
                    print(userInfo["userid"])
                    completion(true)
                }else{
                    completion(false)
                }
            default:
                return
            }
        }
    }
}
