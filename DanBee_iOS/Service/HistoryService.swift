//
//  HistoryService.swift
//  DanBee_iOS
//
//  Created by 남수김 on 22/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

class HistoryService {
    static let shared = HistoryService()
    
    func getHistoryResult(userid: String, completion: @escaping (_: [History]) -> Void){
        
        let url = DanBeeAPI.historyURL + "\(userid)"
        
        Alamofire.request(url).responseJSON{
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let result = json["result"].intValue
                if result == 777 {
                    let datas = json["data"].arrayValue
                    var items = [History]()
                    for data in datas{
                        
                        let start = data["start"].stringValue
                        let end = data["end"].stringValue
                        let kickid = data["kickid"].intValue
                        let userid = data["userid"].stringValue
                        let id = data["id"].intValue
                        items.append( History(start: start, end: end, kickid: kickid, userid: userid, id: id) )
                    }
                    
                    completion(items)
                    
                }
                
            default:
                return
            }
        }
    }
}
