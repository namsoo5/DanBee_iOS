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
import RxOptional

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
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let disposeBag = DisposeBag()
    let textViewModel = TextViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
        bindInput()
        bindOutPut()

    }
    
    @IBAction func signUpButtonClick(_ sender: UIButton) {
        let id = self.textViewModel.idObservable.value
        let pw = self.textViewModel.pwObservable.value
        let phone = self.textViewModel.phoneNumberObservable.value
        let gender = self.textViewModel.gender
        let birth = self.textViewModel.birthObservable.value
        let name = self.textViewModel.nameObservable.value
        
        // Review: [Refactoring] Presenter의 로직은 ViewModel에서 판단하는 것이 좋습니다.
        if birth.isEmpty || phone.isEmpty || name.isEmpty || gender == -1 {
            self.simpleAlert(title: "확인", msg: "빈칸이 있는지 확인해주세요")
            return
        }
        self.indicator.startAnimating()
        sender.isEnabled = false
        SignUpService.shared.getSignUpResult(userid: id, pw: pw, phone: phone, gender: gender, birth: birth, name: name){ b in
            self.indicator.stopAnimating()
            self.signUpButton.isEnabled = true
            if !b {
                self.simpleAlert(title: "오류", msg: "알 수 없는 오류로 회원가입에 실패하였습니다.")
            }else{
                self.toRootAlert(title: "환영합니다", msg: "단비에 가입되셨습니다.")
            }
            
        }
    }
    
    @IBAction func confirmButtonClick(_ sender: Any) {
        
        //사용가능 아이디
        let id = self.textViewModel.idObservable.value
        CheckIdService.shared.getCheckIdResult(userid: id){ b in
            if b{
                self.textViewModel.idVaildObservable.asObserver().onNext(true)
                self.simpleAlert(title: "사용 가능", msg: "사용 가능한 아이디입니다.")
            }else {
                 self.simpleAlert(title: "다시 입력해주세요", msg: "이미 존재하는 아이디입니다.")
            }
        }
        
    }
    
    @IBAction func womanClick(_ sender: CheckboxButton) {
        if sender.on {
            self.manCheckBox.on = false
            self.textViewModel.gender = 0
        }
    }
    @IBAction func manClick(_ sender: CheckboxButton) {
        if sender.on {
            self.womanCheckBox.on = false
            self.textViewModel.gender = 1
        }
    }
}

extension SignUpViewController {
    
    func uiSet(){
        //재확인라벨
        self.confirmPwLabel.isHidden = true
        //패스워드 형식 확인컬러
        self.pwCheckColorView.isHidden = true
        self.pwCheckColorView.layer.cornerRadius = 5
        //회원가입버튼
        self.signUpButton.isEnabled = false
        self.signUpButton.backgroundColor = UIColor.lightGray
        
    }
    
    func bindInput() {
        
        
        self.idTextField.rx.text.orEmpty
            // Review: [사용성] microseconds 은 너무 작지 않나요? ㅎㅎ
            // RxTimeInterval.milliseconds(500) 아마 이걸 의도하신 것 같네요 ㅎ
            .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance) // 0.5sec
            .distinctUntilChanged()
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
        
        self.phoneTextField.rx.text.orEmpty
            .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance) // 0.5sec
            .bind(to: self.textViewModel.phoneNumberObservable)
            .disposed(by: disposeBag)
        
        self.birthTextField.rx.text.orEmpty
            .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance) // 0.5sec
            .bind(to: self.textViewModel.birthObservable)
            .disposed(by: disposeBag)
        
        self.nameTextField.rx.text.orEmpty
            .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance) // 0.5sec
            .bind(to: self.textViewModel.nameObservable)
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
                if !b {
                    self.confirmIdButton.isEnabled = true
                    self.confirmIdButton.backgroundColor = UIColor.danbeeColor1
                }else {
                    self.confirmIdButton.isEnabled = false
                    self.confirmIdButton.backgroundColor = UIColor.lightGray
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
        
        //회원가입 가능상태
        self.textViewModel.buttonEnable
            .subscribe(onNext: { b in
                if !b {
                    self.signUpButton.isEnabled = false
                    self.signUpButton.backgroundColor = UIColor.lightGray
                }else{
                    self.signUpButton.isEnabled = true
                    self.signUpButton.backgroundColor = UIColor.danbeeColor1
                }
            })
        .disposed(by: disposeBag)
                
                
        
    }
    
}
