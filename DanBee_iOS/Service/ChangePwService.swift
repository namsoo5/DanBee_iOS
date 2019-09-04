//
//  ChangePwService.swift
//  DanBee_iOS
//
//  Created by 남수김 on 20/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct ChangePwService {
    private init() { }
    static let shared = ChangePwService()
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    func getChangePwResult(id: String, pw: String, completion: @escaping (_ b: Bool) -> Void) {
        
        let url = DanBeeAPI.changePwURL+"\(id)/\(pw)"
        
        Alamofire.request(url).responseJSON {
            response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let result = json["result"].intValue
                if result == 777 {
                    completion(true)
                }else {
                    completion(false)
                }
                
            default:
                return
            }
        }
    }
}
