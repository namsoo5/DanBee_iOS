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
                        let id = data["id"].intValue
                        let time = data["time"].stringValue
                        let title = data["title"].stringValue
                        let content = data["content"].stringValue
                        items.append( Notice(id: id, date: time, title: title, content: content, open: false) )
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
                        let id = data["id"].intValue
                        let time = data["time"].stringValue
                        let title = data["title"].stringValue
                        let content = data["content"].stringValue
                        items.append( Notice(id: id, date: time, title: title, content: content, open: false) )
                    }
                    completion(items)
                }
                
            default:
                return
            }
        }
    }
    
    func getWriteResult(type: Int, title: String, content: String, completion: @escaping(_: Bool)-> Void ) {
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        let url = type == 0 ? DanBeeAPI.noticeWriteURL : DanBeeAPI.questionWriteURL
        
        let noticeBody: Parameters = [
            "title": title,
            "content": content
        ]
        
        let questionBody: Parameters = [
            "userid": UserInfo.shared.userid,
            "title": title,
            "content": content
        ]
        
        let body = type == 0 ? noticeBody : questionBody
        
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON {
            response in
            
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let result = json["result"].intValue
                
                if result == 777{
                    completion(true)
                }else{
                    completion(false)
                }
            default:
                completion(false)
            }
        }
        
    }
    
    func getDeleteResult(type: Int, id: Int, completion: @escaping(_: Bool)->Void ){
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        let url = type == 0 ? DanBeeAPI.noticeDeleteURL : DanBeeAPI.questionDeleteURL
        
        let body: Parameters = [
            "id": id
        ]
        
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON {
            response in
            
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let result = json["result"].intValue
                
                if result == 777{
                    completion(true)
                }else{
                    completion(false)
                }
            default:
                completion(false)
            }
        }
        
    }
}
