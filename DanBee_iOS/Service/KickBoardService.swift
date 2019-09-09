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
    //QR통신, 대여통신
    func getQRCodeResult(suburl: String, completion: @escaping (_: Int) -> Void){
        
        let url = suburl + "/\(UserInfo.shared.userid)"
        
        Alamofire.request(url).responseJSON{
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let result = json["result"].intValue
                if result == 777 {
                    let time = json["time"].stringValue
                    UserInfo.shared.timeTextObservable.onNext(time)
                }
                completion(result)
                
            default:
                return
            }
        }
    }
    //반납통신
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
    //킥보드 위치통신
    func getGPSResult(completion: @escaping (_: Bool, _ : [KickBoard])->Void){
        
        let url = DanBeeAPI.kickGPSURL
        
        Alamofire.request(url).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let result = json["result"].intValue
                
                if result == 777{
                
                let datas = json["data"].arrayValue
                    var kicks = [KickBoard]()
                    for data in datas{
                        let id = data["id"].intValue
                        let lat = data["lat"].stringValue
                        let lng = data["lng"].stringValue
                        let battery = data["battery"].intValue
                        
                        kicks.append(KickBoard(id: id, lat: Double(lat)!, lng: Double(lng)!, battery: battery))
                    }
                    
                    completion(true, kicks)
                }else{
                    completion(false, [KickBoard]())
                }
                
                
            default:
                completion(false, [KickBoard]())
                
            }
            
        }
    }
}
