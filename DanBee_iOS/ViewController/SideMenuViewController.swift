//
//  SideMenuViewController.swift
//  DanBee_iOS
//
//  Created by 남수김 on 15/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    let menuList = ["QR코드","내정보","이용내역","공지사항/Q&A","사용방법"]
    let menuImg = ["qrcode","profile","","notice",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        uiSet()
    }
    
   
    
    @IBAction func loginButtonClick(_ sender: Any) {
        
        if UserInfo.shared.userid.isEmpty {
            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "Login") else {return}
            self.present(nextVC, animated: true)
        }else {
            UserInfo.shared.logout()
            self.dismiss(animated: true)
        }
    }
}

extension SideMenuViewController {
    
    func uiSet(){
        self.tableView.separatorColor = UIColor.clear
        //login상태에따른 버튼유무
        if UserInfo.shared.userid.isEmpty {
            self.loginButton.setTitle("로그인", for: .normal)
            self.loginImg.image = UIImage(named: "unlock")
        }else {
            self.loginButton.setTitle("로그아웃", for: .normal)
            self.loginImg.image = UIImage(named: "lock")
        }
    }
}

extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SideMenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "menu", for: indexPath) as! SideMenuTableViewCell
        
        cell.menuLabel.text = menuList[indexPath.row]
        cell.icon.image = UIImage(named: menuImg[indexPath.row])
        return cell
    }
    
    
}
