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
    // Review: [Refactoring] Static 이면서 일반 객체로 생성이 가능합니다.
//    private init() {}
    static let shared = SignUpService()
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]

    // Review: [Refactroing] Parameter 가 너무 많습니다.
    // struct 으로 request 객체를 만드는 것이 좋습니다.
//    http://minsone.github.io/mac/ios/how-to-make-json-data-using-mirror-in-swift2
    // Swift의 Mirror를 활용하면 객체 -> Dictionary 형태로 만들 수 있습니다.
    func getSignUpResult(userid: String, pw: String, phone: String, gender: Int, birth: String, name: String, completion: @escaping (_ b: Bool) -> Void) {
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
                // Review: [Refactoring] result 777 상수의 의미는...??
                // Type을 갖는 형태로 관리하는 것이 Refactoring 에 좋아보입니다.
                /*
                enum ResultCode: Int {
                    case tripleSeven = 777
                }
 */
                if result == 777 {
                    completion(true)
                }else {
                    completion(false)
                }
            // Review: [사용성] 실패했을 때 처리가 없습니다.
            default:
                return
            }
        }
    }
}
