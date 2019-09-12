//
//  ProfileViewController.swift
//  DanBee_iOS
//
//  Created by 남수김 on 20/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import MaterialCard

class ProfileViewController: UIViewController {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
        userInfoSet()
    }
    
    @IBAction func removeUserButtonClick(_ sender: Any) {
        
        self.choiceAlert(title: "확인", msg: "정말 탈퇴 하시겠습니까?", okHandler: { action in
            DeleteUserService.shared.getDeleteUserResult(userid: UserInfo.shared.userid){ b in
                if b {
                    UserInfo.shared.logout()
                    self.toRootAlert(title: "확인", msg: "탈퇴 되었습니다.")
                }else{
                    self.simpleAlert(title: "실패", msg: "처리 도중 알 수 없는오류가 발생했습니다.")
                }
            }
        })
        
    }
  
    @IBAction func changePwButtonClick(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ChangePw") else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension ProfileViewController {
    func uiSet(){
        self.userImg.layer.borderColor = UIColor.black.cgColor
        self.userImg.layer.cornerRadius = 45
        self.userImg.layer.borderWidth = 2
    }
    
    func userInfoSet(){
        idLabel.text = UserInfo.shared.userid
        birthLabel.text = UserInfo.shared.birth
        phoneLabel.text = UserInfo.shared.phone
        nameLabel.text = UserInfo.shared.name
    }
    
}

