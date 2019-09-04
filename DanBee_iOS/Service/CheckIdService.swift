//
//  CheckIdService.swift
//  DanBee_iOS
//
//  Created by 남수김 on 17/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CheckIdService {
    private init() { }
    static let shared = CheckIdService()
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    func getCheckIdResult(userid: String, completion: @escaping (_ b: Bool) -> Void) {
        
        let url = DanBeeAPI.checkIdURL+"\(userid)"
        
        Alamofire.request(url).responseJSON {
            response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let result = json["result"].intValue
                if result == 404 {
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
