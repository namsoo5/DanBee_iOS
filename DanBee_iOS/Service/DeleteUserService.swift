//
//  DeleteUserService.swift
//  DanBee_iOS
//
//  Created by 남수김 on 21/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DeleteUserService {
    static let shared = DeleteUserService()
    
    func getDeleteUserResult(userid: String, completion: @escaping (_: Bool) -> Void){
        
        let url = DanBeeAPI.deleteUserURL + "\(userid)"
        
        Alamofire.request(url).responseJSON{
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
