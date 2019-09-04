//
//  NoticeService.swift
//  DanBee_iOS
//
//  Created by 남수김 on 24/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NoticeService {
    private init() { }
    static let shared = NoticeService()
    
    func getNoticeResult(completion: @escaping (_: [Notice]) -> Void){
        
        let url = DanBeeAPI.noticeURL
        
        Alamofire.request(url).responseJSON{
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let result = json["result"].intValue
                if result == 777 {
                    let datas = json["data"].arrayValue
                    var items = [Notice]()
                    for data in datas{
            
                        let time = data["time"].stringValue
                        let title = data["title"].stringValue
                        let content = data["content"].stringValue
                        items.append( Notice(date: time, title: title, content: content, open: false) )
                    }
                    completion(items)
                }
                
            default:
                return
            }
        }
    }
    func getQuestionResult(completion: @escaping (_: [Notice]) -> Void){
        
        let url = DanBeeAPI.questionURL
        
        Alamofire.request(url).responseJSON{
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let result = json["result"].intValue
                if result == 777 {
                    let datas = json["data"].arrayValue
                    var items = [Notice]()
                    for data in datas{
                        let time = data["time"].stringValue
                        let title = data["title"].stringValue
                        let content = data["content"].stringValue
                        items.append( Notice(date: time, title: title, content: content, open: false) )
                    }
                    completion(items)
                }
                
            default:
                return
            }
        }
    }
}
