//
//  SignUpService.swift
//  DanBee_iOS
//
//  Created by 남수김 on 16/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct SignUpService {
    static let shared = SignUpService()
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    func getSignUpResult(userid: String, pw: String, phone: String, gender: Int, birth: String, name: String, completion: @escaping () -> Void) {
        
        let body: Parameters = [
            "userid": userid,
            "pw": pw,
            "phone": phone,
            "gender": gender,
            "birth": birth,
            "name": name
        ]
        
        Alamofire.request(DanBeeAPI.signUpURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON {
            response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let result = json["result"].intValue
                if result == 2000 {
                    completion()
                }
                
            default:
                return
            }
        }
    }
}
