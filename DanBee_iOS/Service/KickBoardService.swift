//
//  KickBoardService.swift
//  DanBee_iOS
//
//  Created by 남수김 on 03/09/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class KickBoardService {
    private init() { }
    static let shared = KickBoardService()
    
    func getQRCodeResult(suburl: String, completion: @escaping (_: Int) -> Void){
        
        let url = suburl + "/\(UserInfo.shared.userid)"
        
        Alamofire.request(url).responseJSON{
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let result = json["result"].intValue
                if result == 777 {
                    UserInfo.shared.time = json["time"].stringValue
                    UserInfo.shared.stateViewVisibleObservable.onNext(true)
                }
                completion(result)
                
            default:
                return
            }
        }
    }
    
    func getLendResult(completion: @escaping (_: Int) -> Void){
        
        let url = DanBeeAPI.lendURL + "\(UserInfo.shared.userid)"
        
        Alamofire.request(url).responseJSON{
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let result = json["result"].intValue
                
                completion(result)
                
            default:
                return
            }
        }
    }
}
