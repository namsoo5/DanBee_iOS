//
//  SearchUserService.swift
//  DanBee_iOS
//
//  Created by 남수김 on 19/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct SearchUserService {
    private init() { }
    static let shared = SearchUserService()
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    func getSearchIdResult(name: String, phone: String, completion: @escaping (_ b: String) -> Void) {
        
        let url = DanBeeAPI.searchIdURL+"\(name)/\(phone)"
        
        Alamofire.request(url).responseJSON {
            response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let result = json["result"].intValue
                if result == 777 {
                    completion(json["data"].stringValue)
                }else {
                    completion("")
                }
                
            default:
                completion("")
            }
        }
    }
    
    func getSearchPwResult(userid: String, name: String, phone: String, birth: String, completion: @escaping (_ b: Bool) -> Void) {
        
        let url = DanBeeAPI.searchPwURL+"\(userid)/\(name)/\(phone)/\(birth)"
        
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
                completion(false)
            }
        }
    }
}
