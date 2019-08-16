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

    }
    
    @IBAction func signUpButtonClick(_ sender: Any) {
    }
    
    @IBAction func confirmButtonClick(_ sender: Any) {
    }
}

extension SignUpViewController {
    
    func uiSet(){
        
    }
    
    func bindInput() {
        //id변경시 중복확인 다시누르도록
        self.idTextField.rx.text.orEmpty
            .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance) // 0.5sec
            .subscribe(onNext: { text in
                if self.textViewModel.idText != text {
                    self.textViewModel.idVaild = false
                    self.confirmIdButton.isEnabled = true
                }
                self.textViewModel.idText = text
            })
            .disposed(by: disposeBag)
        
        self.pwTextField.rx.text.orEmpty
        .bind(to: self.textViewModel.pwText)
        .disposed(by: disposeBag)
        
    }
    
    func bindOutPut(){
        
        self.textViewModel.pwVaild
            .subscribe(onNext: { b in
                if b {
                    self.pwCheckColorView.backgroundColor = UIColor.blue
                } else {
                    self.pwCheckColorView.backgroundColor = UIColor.red
                }
            })
        .disposed(by: disposeBag)
        
        self.textViewModel.pwConfirmVaild
            .subscribe(onNext: { b in
                if b {
                    self.confirmPwLabel.text = "일치"
                    self.confirmPwLabel.textColor = UIColor.blue
                } else {
                    
                    self.confirmPwLabel.text = "불일치"
                    self.confirmPwLabel.textColor = UIColor.red
                }
            })
    }
    
}
