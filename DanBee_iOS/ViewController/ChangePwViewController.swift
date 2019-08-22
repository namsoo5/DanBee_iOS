//
//  ChangePwViewController.swift
//  DanBee_iOS
//
//  Created by 남수김 on 19/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ChangePwViewController: UIViewController {

    @IBOutlet weak var pwColorView: UIView!
    @IBOutlet weak var pwColorLabel: UILabel!
    @IBOutlet weak var checkPwTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    var userid = String()
    var viewModel = ChangePwViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindInput()
        bindOutput()
        uiSet()
    }
    
    @IBAction func changePwButtonClick(_ sender: Any) {
        if self.viewModel.buttonVaild.value {
            let pw = self.pwTextField.text ?? ""
            ChangePwService.shared.getChangePwResult(id: self.userid, pw: pw){ b in
                if b {
                    self.toRootAlert(title: "성공", msg: "비밀번호를 변경하였습니다.")
                    
                }else {
                    self.simpleAlert(title: "실패", msg: "알 수 없는 오류가 발생하였습니다.")
                }
            }
        }
    }
    
}

extension ChangePwViewController {
    
    func uiSet() {
        self.pwColorView.layer.cornerRadius = 5
    }
    
    func bindInput() {
        self.pwTextField.rx.text.orEmpty
        .bind(to: self.viewModel.pwObservable)
        .disposed(by: disposeBag)
        
        self.checkPwTextField.rx.text.orEmpty
        .bind(to: self.viewModel.pwCheckObservable)
        .disposed(by: disposeBag)
        
    }
    
    func bindOutput() {
        //비밀번호 형식맞는지 컬러로 표시
        self.viewModel.pwVaildObservable
            .subscribe(onNext: { [weak self] b in
                if b {
                    self?.pwColorView.backgroundColor = UIColor.blue
                }else{
                    self?.pwColorView.backgroundColor = UIColor.red
                }
            })
        .disposed(by: disposeBag)
        
        //재확인 일치확인
        self.viewModel.pwCheckVaildObservable
            .subscribe(onNext: { [weak self] b in
                if b {
                    self?.pwColorLabel.text = "일치"
                    self?.pwColorLabel.textColor = UIColor.blue
                } else {
                    self?.pwColorLabel.text = "불일치"
                    self?.pwColorLabel.textColor = UIColor.red
                }
            })
        .disposed(by: disposeBag)
        
    }
 
}
