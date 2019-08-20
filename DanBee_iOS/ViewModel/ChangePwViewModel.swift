//
//  ChangePwViewModel.swift
//  DanBee_iOS
//
//  Created by 남수김 on 20/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ChangePwViewModel {
    let pwObservable: BehaviorRelay<String> = BehaviorRelay(value: "")
    let pwVaildObservable: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    let pwCheckObservable: BehaviorRelay<String> = BehaviorRelay(value: "")
    let pwCheckVaildObservable: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    let buttonVaild: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    let disposeBag = DisposeBag()
    
    init() {
        bindSet()
    }
    
    func bindSet(){
        //비번형식체크
        pwObservable.map(pwCheck)
            .bind(to: pwVaildObservable)
            .disposed(by: disposeBag)
        
        //비번재확인
        pwCheckObservable.map(samePwCheck2)
            .bind(to: pwCheckVaildObservable)
            .disposed(by: disposeBag)
        
        //비밀번호바뀔시 다시 확인
        pwObservable.map(samePwCheck1)
            .bind(to: pwCheckVaildObservable)
            .disposed(by: disposeBag)
        
        //비번형식 둘다만족시 변경가능
        Observable.combineLatest(pwVaildObservable, pwCheckVaildObservable, resultSelector: { $0 && $1 && true })
        .bind(to: buttonVaild)
        .disposed(by: disposeBag)
    }
    
    func pwCheck(_ s: String) -> Bool {
        if s.count > 2 {
            return true
        }else{
            return false
        }
    }
    
    func samePwCheck1 (_ s: String) -> Bool {
        if s != pwCheckObservable.value || pwCheckObservable.value.isEmpty {
            return false
        }else {
            return true
        }
    }
    
    func samePwCheck2 (_ s: String) -> Bool {
        if s != pwObservable.value || pwObservable.value.isEmpty {
            return false
        }else {
            return true
        }
    }

}
