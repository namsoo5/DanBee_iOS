//
//  LoginViewController.swift
//  DanBee_iOS
//
//  Created by 남수김 on 16/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import CheckboxButton

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var autoLoginCheckBox: CheckboxButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
        backButtonInit()
    
    }
    
    @IBAction func loginButtonClick(_ sender: Any) {
        guard let id = self.idTextField.text else {return}
        guard let pw = self.pwTextField.text else {return}
        LoginService.shared.getLoginResult(userid: id, pw: pw){ b in
            if !b {
                self.simpleAlert(title: "로그인 실패", msg: "아이디 혹은 비밀번호가 틀렸습니다.")
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}

extension LoginViewController {
    
    func uiSet() {
        
    }
    
    func backButtonInit(){
        let menuButton = UIBarButtonItem.init(title: "Back", style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = menuButton
    }
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
