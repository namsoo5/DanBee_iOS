//
//  History.swift
//  DanBee_iOS
//
//  Created by 남수김 on 22/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation

struct History {
    let start: String
    let end: String
    let kickid: Int
    let userid: String
    let id: Int
    
    //사용시간 연산
    mutating func useTimeFormatter() -> String {
        // Review: [Refactoring] DateFormatter의 코드에 중복이 보입니다.
        // 별도의 Util class로 만들어서 날짜 데이터를 제공하는 것이 좋을 것 같습니다!
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let startTime = format.date(from: self.start) else {return "?"}
        guard let endTime = format.date(from: self.end) else {return "?"}
        
        var useTime = Int(endTime.timeIntervalSince(startTime))
        if useTime/60 == 0 {
            useTime = 1
        }
        return "\(useTime/60) 분"
    }
    
    mutating func dateFormatter() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let startTime = format.date(from: self.start) else {return "?"}
        guard let endTime = format.date(from: self.end) else {return "?"}
        
        //원하는 형식으로 다시 바꾸기
        format.dateFormat = "HH:mm"
        let s = format.string(from: startTime)
        let e = format.string(from: endTime)
        
        format.dateFormat = "yyyy.MM.dd"
        let f = format.string(from: startTime)
        let dateText = "\(f) (\(s) - \(e))"
        
        return dateText
        
    }
}
