//
//  SignUpTextField.swift
//  DanBee_iOS
//
//  Created by 남수김 on 16/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TextViewModel {
    let disposeBag = DisposeBag()
    let pwText: BehaviorSubject<String> = BehaviorSubject(value: "")
    var idText = String()
    let pwVaild: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    var idVaild = Bool()
    private var confirmPw = String()
    let pwConfirmVaild: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    init() {
        setting()
    }
    
    
    func setting(){
        
        pwText.map(pwCheck)
            .bind(to: pwVaild)
            .disposed(by: disposeBag)
        
        
        pwText.subscribe(onNext: { s in
            self.confirmPw = s
        })
        .disposed(by: disposeBag)
        
        pwText.map(confirmPw)
            .bind(to: pwConfirmVaild)
            .disposed(by: disposeBag)
    }
    
    func pwCheck(_ s: String) -> Bool {
        if s.count > 2 {
            return true
        }else{
            return false
        }
    }
    
    func confirmPw(_ s: String) -> Bool {
        if s == self.confirmPw {
            return true
        }else {
            return false
        }
    }
    
}
