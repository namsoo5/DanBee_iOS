//
//  SignUpViewController.swift
//  DanBee_iOS
//
//  Created by 남수김 on 16/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import CheckboxButton
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var confirmPwTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var manCheckBox: CheckboxButton!
    @IBOutlet weak var womanCheckBox: CheckboxButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var confirmIdButton: UIButton!
    @IBOutlet weak var confirmPwLabel: UILabel!
    @IBOutlet weak var pwCheckColorView: UIView!
    
    let disposeBag = DisposeBag()
    let textViewModel = TextViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
        bindInput()
        bindOutPut()
    }
    
    @IBAction func signUpButtonClick(_ sender: Any) {
    }
    
    @IBAction func confirmButtonClick(_ sender: Any) {
    }
}

extension SignUpViewController {
    
    func uiSet(){
        self.confirmPwLabel.isHidden = true
        self.pwCheckColorView.isHidden = true
    }
    
    func bindInput() {
        
        self.idTextField.rx.text.orEmpty
        .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance) // 0.5sec
        .bind(to: self.textViewModel.idObservable)
        .disposed(by: disposeBag)
        
        self.pwTextField.rx.text.orEmpty
        .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance) // 0.5sec
        .bind(to: self.textViewModel.pwObservable)
        .disposed(by: disposeBag)
        
        self.confirmPwTextField.rx.text.orEmpty
        .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance) // 0.5sec
        .bind(to: self.textViewModel.pwCheckObservable)
        .disposed(by: disposeBag)
       
        
    }
    
    func bindOutPut(){
        //빈칸이면 표시x
        self.textViewModel.pwObservable
            .subscribe(onNext: { s in
                if s.isEmpty {
                    self.pwCheckColorView.isHidden = true
                }else {
                    self.pwCheckColorView.isHidden = false
                }
            })
        .disposed(by: disposeBag)
        
        //빈칸이면 표시x
        self.textViewModel.pwCheckObservable
            .subscribe(onNext: { s in
                if s.isEmpty {
                    self.confirmPwLabel.isHidden = true
                }else {
                    self.confirmPwLabel.isHidden = false
                }
            })
            .disposed(by: disposeBag)
        
        //아이디 변경할시 다시 중복버튼 눌러야함
        self.textViewModel.idVaildObservable
            .subscribe(onNext: { b in
                if b {
                    self.confirmIdButton.isEnabled = true
                }
            })
        .disposed(by: disposeBag)
        
        //패스워드 형식체크
        self.textViewModel.pwVaildObservable
            .subscribe(onNext: { b in
                if b {
                    self.pwCheckColorView.backgroundColor = UIColor.blue
                } else {
                    self.pwCheckColorView.backgroundColor = UIColor.red
                }
            })
        .disposed(by: disposeBag)
        
        //재확인 라벨
        self.textViewModel.pwCheckVaildObservable
            .subscribe(onNext: { b in
                if b {
                    self.confirmPwLabel.text = "일치"
                    self.confirmPwLabel.textColor = UIColor.blue
                } else {
                    self.confirmPwLabel.text = "불일치"
                    self.confirmPwLabel.textColor = UIColor.red
                }
            })
        .disposed(by: disposeBag)
    }
    
}
