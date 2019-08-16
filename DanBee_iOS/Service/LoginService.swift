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
    
    func getLoginResult(userid: String, pw: String, phone: String, gender: Int, birth: String, name: String, completion: @escaping () -> Void) {
        
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
                if result == 2000 {
                    let userInfo = json["data"].arrayValue
                    print(userInfo)
                }
                
            default:
                return
            }
        }
    }
}
//"result"=>self::RESULT_SUCCESS,
//"data"=>array(array(
//"userid"=>$userid,
//"phone"=>$db[0]->phone,
//"name"=>$db[0]->name,
//"gender"=>$db[0]->gender,
//"birth"=>$db[0]->birth
//))
